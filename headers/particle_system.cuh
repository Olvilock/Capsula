#pragma once

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include <thrust/transform.h>
#include <thrust/execution_policy.h>

#include <particle_traits.cuh>
#include <advancer_traits.cuh>

#include <mutex>

constexpr unsigned BLK_SIZE = 128;

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
template</*particle*/typename particle_t>
__global__ void compute_interparticle_forces
(const particle_t* particles,
	typename force_type<particle_t>* forces,
	unsigned* locks);

template</*particle*/ typename particle_t, /*advancer*/ typename advancer_t>
struct particle_system
{
	particle_system(size_t size);
	void advance();
	void compute();

	using particle_type = particle_t;
	using force_type = force_type<particle_type>;
	using constant_type = constant_type<particle_type>;
private:
	thrust::device_vector<particle_t> m_particles;
	thrust::device_vector<force_type> m_forces;
	advancer_t m_advancer;
	std::mutex m_mutex;
};