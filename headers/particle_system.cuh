#pragma once

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include <thrust/transform.h>
#include <thrust/execution_policy.h>

#include <particle_traits.cuh>
#include <advancer_traits.cuh>
#include <compute_forces.cuh>

#include <mutex>

constexpr unsigned BLK_SIZE = 128;

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