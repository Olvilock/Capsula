#pragma once

#include <device_launch_parameters.h>
#include <particle_system.cuh>

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
template</*particle*/typename particle_t>
__global__ void compute_interparticle_forces
	(const particle_t* particles, force_type<particle_t>* forces, unsigned* locks)
{
	unsigned local_id = threadIdx.x;
	unsigned global_id = local_id + BLK_SIZE * blockIdx.x;
	unsigned global_load = local_id + BLK_SIZE * blockIdx.y;

	force_type<particle_t> frc{};
	particle_t ptc = particles[global_id];

	__shared__ particle_t ptc_cache[BLK_SIZE];
	ptc_cache[local_id] = particles[global_load];
	__syncthreads();

	for (unsigned local_cur = local_id + BLK_SIZE - (blockIdx.x == blockIdx.y);
		local_cur != local_id; --local_cur)
		frc += ptc_cache[local_cur % BLK_SIZE].force_on(ptc);

	if (local_id == 0)
		while (atomicCAS(locks + blockIdx.x, gridDim.x, blockIdx.x) != blockIdx.x);
	__syncthreads();

	forces[global_id] += frc;
	__threadfence();

	if (local_id == 0)
		locks[blockIdx.x] = gridDim.x;
	__syncthreads();
}