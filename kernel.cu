#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <thrust/device_vector.h>

#include "quantities.cuh"
#include "particle.cuh"

constexpr unsigned BLK_SIZE = 128;

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

	for (unsigned index = lc_index;
			   (++index %= blockDim.x) != lc_index; )
		force_cache[lc_index] += par_cache[index].force_on(par_cache[lc_index]);

	__shared__ particle par_temp[BLK_SIZE];
	for (unsigned other_index = blockDim.x * (gridDim.x - 1) + lc_index;
		other_index != lc_index;
		other_index -= blockDim.x)
	{
		if (other_index == gl_index)
			continue;

		par_temp[lc_index] = particles[other_index];
		__syncthreads();

		unsigned index = lc_index;
		do
			force_cache[lc_index] += par_temp[index].force_on(par_cache[lc_index]);
		while ((++index %= blockDim.x) != lc_index);
	}
	__syncthreads();
	forces[gl_index] = force_cache[lc_index];
}

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