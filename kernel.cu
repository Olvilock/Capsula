#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <thrust/device_vector.h>

#include "quantities.cuh"
#include "particle.cuh"

__constant__ time_type time_step = 1.0e-4;
constexpr unsigned BLK_SIZE = 256;

__global__
void interpar_compute(particle* particles, inter_type* forces)
{
	__shared__ particle current[BLK_SIZE];
	__shared__ inter_type force_temp[BLK_SIZE];

	unsigned lc_index = threadIdx.x;
	unsigned gl_index = threadIdx.x + blockIdx.x * blockDim.x;
	current[lc_index] = particles[gl_index];
	force_temp[lc_index] = inter_type();

	for (unsigned i = lc_index; i != lc_index; )
	{
		if (++i == blockDim.x)
			i = 0;
		//TODO
	}

	__shared__ particle par_temp[BLK_SIZE];
	for (unsigned other_index = blockDim.x * (gridDim.x - 1) + lc_index;
		other_index != gl_index;
		other_index -= blockDim.x)
	{
		par_temp[lc_index] = particles[other_index];
		unsigned i = lc_index;
		do
		{
			//TODO
			if (++i == blockDim.x)
				i = 0;
		} while (i != lc_index);
	}

	//TODO
}

__inline__
void compute(thrust::device_vector<particle>& particles, thrust::device_vector<inter_type>& forces)
{
	assert(particles.size() % BLK_SIZE == 0);
	assert(particles.size() == forces.size());
	interpar_compute <<< BLK_SIZE, particles.size() / BLK_SIZE >>>
		(thrust::raw_pointer_cast(particles.data()),
		 thrust::raw_pointer_cast(forces.data()));
}

int main()
{
	//TODO
}