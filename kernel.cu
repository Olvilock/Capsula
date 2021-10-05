#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/iterator/zip_iterator.h>
#include <thrust/execution_policy.h>

#include <stdio.h>

#include "quantities.cuh"

__constant__ time_type time_step = 1e-5;

#include "particle.cuh"

constexpr unsigned BLK_SIZE = 128;

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
__global__
void interpar_compute(particle* particles, force_type* forces, unsigned* locks)
{
	unsigned local_id = threadIdx.x;
	unsigned global_id = local_id + BLK_SIZE * blockIdx.y;
	unsigned global_cur = local_id + BLK_SIZE * blockIdx.x;

	force_type force{};
	particle par = particles[global_cur];

	__shared__ particle par_cache[BLK_SIZE];

	par_cache[local_id] = particles[global_id];
	__syncthreads();

	for (unsigned index = local_id + BLK_SIZE - (global_cur == global_id);
		index != local_id; --index)
		force += par_cache[index % BLK_SIZE].force_on(par);

	if (local_id == 0)
		while (atomicCAS(locks + blockIdx.x, gridDim.x, blockIdx.x) != blockIdx.x);
	__syncthreads();

	forces[global_cur] += force;
	__threadfence();

	if (local_id == 0)
		locks[blockIdx.x] = gridDim.x;
	__syncthreads();
}

void compute(thrust::device_vector<particle>& particles,
			 thrust::device_vector<force_type>& forces)
{
	assert(particles.size() % BLK_SIZE == 0);
	assert(particles.size() == forces.size());

	unsigned blk_dim = particles.size() / BLK_SIZE;
	thrust::device_vector<unsigned> locks(blk_dim, blk_dim);

	interpar_compute <<< dim3(blk_dim, blk_dim), BLK_SIZE >>>
		(thrust::raw_pointer_cast(particles.data()),
			thrust::raw_pointer_cast(forces.data()),
			thrust::raw_pointer_cast(locks.data()));
}

void advance(thrust::device_vector<particle>& particles,
			 thrust::device_vector<force_type>& forces)
{
	assert(particles.size() == forces.size());

	thrust::for_each_n(thrust::device,
		thrust::make_zip_iterator(thrust::make_tuple(particles.begin(), forces.begin())),
		particles.size(),
		[] __device__(thrust::tuple<particle&, force_type&> tpl)
		{
			tpl.get<0>().advance(tpl.get<1>());
			tpl.get<1>().reset();
		});
}

int main()
{
	thrust::device_vector<particle> pts(1024 * 64);
	thrust::device_vector<force_type> forces(1024 * 64);

	for (int i = 0; i < 10; ++i)
	{
		std::cout << "Computation " << i << " started...\n";
		compute(pts, forces);

		std::cout << (force_type)forces[0] << std::endl;

		advance(pts, forces);
	}
}