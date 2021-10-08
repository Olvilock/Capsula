#pragma once

#include <device_launch_parameters.h>
#include <general/compute_all_forces.cuh>

#ifdef __CUDACC__
template<typename particle_t>
#else
template<interactable_particle particle_t>
#endif
constexpr unsigned BLK_SIZE()
{
	return 128;
}

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only#ifdef __CUDACC__
#ifdef __CUDACC__
template<typename particle_t>
#else
template<interactable_particle particle_t>
#endif
__global__ void compute_interparticle_forces
	(const particle_t* particles, force_type<particle_t>* forces, unsigned* locks)
{
	unsigned local_id = threadIdx.x;
	unsigned global_id = local_id + BLK_SIZE<particle_t>() * blockIdx.x;
	unsigned global_load = local_id + BLK_SIZE<particle_t>() * blockIdx.y;

	force_type<particle_t> frc{};
	particle_t ptc = particles[global_id];

	__shared__ particle_t ptc_cache[BLK_SIZE<particle_t>()];
	ptc_cache[local_id] = particles[global_load];
	__syncthreads();

	for (unsigned local_cur = local_id + BLK_SIZE<particle_t>() - (blockIdx.x == blockIdx.y);
		local_cur != local_id; --local_cur)
		frc += ptc_cache[local_cur % BLK_SIZE<particle_t>()].force_on(ptc);

	if (local_id == 0)
		while (atomicCAS(locks + blockIdx.x, gridDim.x, blockIdx.x) != blockIdx.x);
	__syncthreads();

	forces[global_id] += frc;
	__threadfence();

	if (local_id == 0)
		locks[blockIdx.x] = gridDim.x;
	__syncthreads();
}