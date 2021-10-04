#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/iterator/zip_iterator.h>
#include <thrust/tuple.h>

#include <thrust/for_each.h>
#include <thrust/execution_policy.h>

#include <stdio.h>
#include <iostream>

#include "quantities.cuh"
#include "particle.cuh"

constexpr unsigned BLK_SIZE = 128;

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
__global__
void interpar_compute(particle* particles, force_type* forces)
{
	unsigned local_id = threadIdx.x;
	unsigned global_id = local_id + BLK_SIZE * blockIdx.x;
	force_type force = forces[global_id];
	particle par = particles[global_id];

	__shared__ particle par_cache[BLK_SIZE];

	for (unsigned group_id = BLK_SIZE * gridDim.x + local_id;
		group_id != local_id; )
	{
		group_id -= BLK_SIZE;

		par_cache[local_id] = particles[group_id];
		__syncthreads();

		for (unsigned index = local_id + BLK_SIZE - (group_id == global_id);
			index != local_id; --index)
			force += par_cache[index % BLK_SIZE].force_on(par);
	}

	forces[global_id] = force;
}

void compute(thrust::device_vector<particle>& particles,
			 thrust::device_vector<force_type>& forces)
{
	assert(particles.size() % BLK_SIZE == 0);
	assert(particles.size() == forces.size());
	interpar_compute <<< particles.size() / BLK_SIZE, BLK_SIZE >>>
		(thrust::raw_pointer_cast(particles.data()),
			thrust::raw_pointer_cast(forces.data()));
}

void advance(thrust::device_vector<particle>& particles,
			 thrust::device_vector<force_type>& forces)
{
	assert(particles.size() == forces.size());
	auto begin = thrust::make_zip_iterator(thrust::make_tuple(particles.begin(), forces.begin())),
		 end   = thrust::make_zip_iterator(thrust::make_tuple(particles.end(), forces.end()));
	thrust::for_each(thrust::device, begin, end,
		[] __device__(thrust::tuple<particle&, force_type&> tpl)
		{
			tpl.get<0>().advance(tpl.get<1>());
		});
}

int main()
{
	thrust::device_vector<particle> pts(1024 * 512);
	thrust::device_vector<force_type> forces(1024 * 512);

	std::cout << "Computation started...\n";

	compute(pts, forces);
	/*
	cudaDeviceSynchronize();

	std::cout << "Advancing started...\n";

	advance(pts, forces);

	std::cout << "Ready!\n";

	//	Output the forces:
	thrust::host_vector<force_type> h_forces = forces;

	for (force_type& force : h_forces)
		std::cout << force.force.x << ' ' << force.force.y << ' ' << force.force.z;
	*/
}