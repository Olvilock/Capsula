#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <thrust/device_vector.h>

#include "quantities.cuh"
#include "particle.cuh"

__constant__ time_type time_step = 1.0e-4;
constexpr unsigned BLK_SIZE = 256;

__global__
void interpar_compute(particle* particles, force_type* forces)
{
	__shared__ particle par_cache[BLK_SIZE];
	__shared__ force_type force_cache[BLK_SIZE];

	unsigned lc_index = threadIdx.x;
	unsigned gl_index = threadIdx.x + blockIdx.x * blockDim.x;
	par_cache[lc_index] = particles[gl_index];
	force_cache[lc_index] = forces[gl_index];

	__syncthreads();

	for (unsigned index = lc_index; index != lc_index; )
	{
		if (++index == blockDim.x)
			index = 0;

		force_type cur_force = par_cache[lc_index].force_on(par_cache[index]);
		force_cache[index] += cur_force;
		force_cache[lc_index] -= cur_force;
	}

	__shared__ particle par_temp[BLK_SIZE];
	__shared__ force_type force_temp[BLK_SIZE];
	for (unsigned other_index = blockDim.x * (gridDim.x - 1) + lc_index;
		other_index != gl_index;
		other_index -= blockDim.x)
	{
		par_temp[lc_index] = particles[other_index];
		force_temp[lc_index] = forces[other_index];

		__syncthreads();

		unsigned index = lc_index;
		do
		{
			force_type cur_force = par_cache[lc_index].force_on(par_temp[index]);
			force_temp[index] += cur_force;
			force_cache[lc_index] -= cur_force;

			if (++index == blockDim.x)
				index = 0;
		} while (index != lc_index);

		__syncthreads();

		//TODO memory transfer force_temp -> forces
	}
	//TODO memory transfer force_cache -> forces
}

__inline__
void compute(thrust::device_vector<particle>& particles,
			 thrust::device_vector<force_type>& forces)
{
	assert(particles.size() % BLK_SIZE == 0);
	assert(particles.size() == forces.size());
	interpar_compute <<< BLK_SIZE, particles.size() / BLK_SIZE >>>
		(thrust::raw_pointer_cast(particles.data()),
		 thrust::raw_pointer_cast(forces.data()));
}

int main()
{
	thrust::device_vector<particle> pts(256);
	thrust::device_vector<force_type> forces(256);

	compute(pts, forces);
}