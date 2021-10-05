#pragma once

#include <device_launch_parameters.h>

#include <quantities.cuh>
#include <constants.cuh>
#include <particle.cuh>
#include <particle_system.cuh>

extern __constant__ constant_type constants;

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
__global__
void interpar_compute(const particle_type* particles,
	force_type* forces,
	unsigned* locks)
{
	unsigned local_id = threadIdx.x;
	unsigned global_id = local_id + BLK_SIZE * blockIdx.y;
	unsigned global_cur = local_id + BLK_SIZE * blockIdx.x;

	force_type force{};
	particle_type par = particles[global_cur];

	__shared__ particle_type par_cache[BLK_SIZE];

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