#pragma once

#include "quantities.cuh"
#include "constants.cuh"
#include "particle.cuh"
#include "particle_advancer.cuh"

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include <thrust/transform.h>
#include <thrust/execution_policy.h>

constexpr unsigned BLK_SIZE = 128;

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
__global__
void interpar_compute(const particle_type* particles,
	force_type* forces,
	unsigned* locks);

class particle_system
{
	thrust::device_vector<particle_type> m_particles;
	thrust::device_vector<force_type> m_forces;
	particle_advancer m_advancer;
public:
	particle_system(size_t size);
	void advance();
	void compute();

	using particle_type = particle_type;
	using force_type = force_type;
};