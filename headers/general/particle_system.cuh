#pragma once

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include <thrust/transform.h>
#include <thrust/execution_policy.h>

#include <particle_traits.cuh>
#include "compute_all_forces.cuh"

#include <mutex>

#ifdef __CUDACC__
template<typename particle_t>
#else
template<proper_particle particle_t>
#endif
struct particle_system
{
	using particle_type = particle_t;
	using force_type = force_t<particle_type>;
	using advancer_type = advancer_t<particle_type>;

	particle_system(size_t size);
	void advance();
	void compute();
private:
	thrust::device_vector<particle_type> m_particles;
	thrust::device_vector<force_type> m_forces;
	advancer_type m_advancer;
	bool m_ready;
};