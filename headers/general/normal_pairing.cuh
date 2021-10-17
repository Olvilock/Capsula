#pragma once

#include <particle_traits.cuh>
#include <advancer_traits.cuh>

#include <device_launch_parameters.h>

namespace general
{
#ifndef __CUDACC__

	template<proper_particle Particle>
	inline constexpr unsigned BLK_SIZE();

#else

	template<typename Particle>
	inline constexpr unsigned BLK_SIZE()
	{
		return 128;
	}

#endif

	//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
#ifndef __CUDACC__

	template<proper_particle Particle, typename Force>
	__global__
		inline void normal_pairing(const Particle*, typename Force*, unsigned*);

#else

	template<typename Particle, typename Force>
	__global__
		inline void normal_pairing(const Particle* particles, typename Force* forces, unsigned* locks)
	{
		unsigned local_id = threadIdx.x;
		unsigned global_id = local_id + blockDim.x * blockIdx.x;
		unsigned global_load = local_id + blockDim.x * blockIdx.y;

		Force frc{};
		Particle ptc = particles[global_id];

		__shared__ Particle ptc_cache[BLK_SIZE<Particle>()];
		ptc_cache[local_id] = particles[global_load];
		__syncthreads();

		for (unsigned local_cur = local_id + blockDim.x - (blockIdx.x == blockIdx.y);
			local_cur != local_id; --local_cur)
			frc += ptc_cache[local_cur % blockDim.x].force_on(ptc);

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
}