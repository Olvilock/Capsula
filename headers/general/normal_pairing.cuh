#pragma once

#include <particle_traits.cuh>
#include <advancer_traits.cuh>

#include <device_launch_parameters.h>

#ifndef __CUDACC__

template<proper_particle particle_t>
inline constexpr unsigned BLK_SIZE();

#else

template<typename particle_t>
inline constexpr unsigned BLK_SIZE()
{
	return 128;
}

#endif

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
#ifndef __CUDACC__

template<proper_particle particle_t, typename force_t>
__global__
inline void normal_pairing (const particle_t*, typename force_t*, unsigned*);

#else

template<typename particle_t, typename force_t>
__global__
inline void normal_pairing (const particle_t* particles, typename force_t* forces, unsigned* locks)
{
	unsigned local_id = threadIdx.x;
	unsigned global_id = local_id + BLK_SIZE<particle_t>() * blockIdx.x;
	unsigned global_load = local_id + BLK_SIZE<particle_t>() * blockIdx.y;

	force_t frc{};
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

#endif