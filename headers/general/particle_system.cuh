#pragma once

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include <thrust/transform.h>
#include <thrust/execution_policy.h>

#include <particle_traits.cuh>
#include <advancer_traits.cuh>
#include "compute_all_forces.cuh"

#include <mutex>

#ifdef __CUDACC__
template<typename advancer_t>
#else
template<advancable advancer_t>
#endif
struct particle_system
{
	using advancer_type = advancer_t;
	using particle_type = particle_type<advancer_type>;
	using force_type = force_type<particle_type>;
	using constant_type = constant_type<particle_type>;

	particle_system(size_t size);
	void advance();
	void compute();
private:
	thrust::device_vector<particle_type> m_particles;
	thrust::device_vector<force_type> m_forces;
	advancer_type m_advancer;
	std::mutex m_mutex;
};