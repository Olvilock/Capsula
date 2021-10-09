#pragma once

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include <particle_traits.cuh>
#include "normal_pairing.cuh"

#include <mutex>

#ifdef __CUDACC__
template<typename particle_t>
#else
template<proper_particle particle_t>
#endif
struct particle_system
{
	using particle_type = particle_t;
	using force_type = particle_traits<particle_type>::force_type;
	using advancer_type = particle_traits<particle_type>::advancer_type;

	particle_system(size_t size);
	void advance();
	void compute();
private:
	thrust::device_vector<particle_type> m_particles;
	thrust::device_vector<force_type> m_forces;
	thrust::device_vector<advancer_type> m_advancers;
	bool m_ready;
};