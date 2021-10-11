#pragma once

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include <particle_traits.cuh>
#include <advancer_traits.cuh>

#include "normal_pairing.cuh"

#ifdef __CUDACC__
template<typename particle_t, typename advancer_t>
#else
template<proper_particle particle_t, proper_advancer advancer_t>
#endif
struct particle_system
{
	using particle_type = particle_t;
	using advancer_type = advancer_t;
	using force_type = advancer_traits<advancer_type>::force_type;

	inline particle_system(size_t size);
	inline void advance();
	inline void compute();
private:
	thrust::device_vector<particle_type> m_particles;
	thrust::device_vector<force_type> m_forces;
	thrust::device_vector<advancer_type> m_advancers;
	bool m_ready;
};

#ifdef __CUDACC__

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <thrust/for_each.h>
#include <thrust/iterator/zip_iterator.h>
#include <thrust/execution_policy.h>

template<typename particle_t, typename advancer_t>
inline particle_system<particle_t, advancer_t>::particle_system(size_t size) :
	m_particles(size),
	m_forces(size),
	m_advancers(size)
{
	assert(size % BLK_SIZE<particle_type>() == 0);
}

template<typename particle_t, typename advancer_t>
inline void particle_system<particle_t, advancer_t>::compute()
{
	if (m_ready)
		return;

	assert(m_particles.size() % BLK_SIZE<particle_type>() == 0);

	unsigned blk_dim = m_particles.size() / BLK_SIZE<particle_type>();
	thrust::device_vector<unsigned> locks(blk_dim, blk_dim);

	normal_pairing<particle_type, force_type> <<< dim3(blk_dim, blk_dim), BLK_SIZE<particle_type>() >>>
		(thrust::raw_pointer_cast(m_particles.data()),
			thrust::raw_pointer_cast(m_forces.data()),
			thrust::raw_pointer_cast(locks.data()));

	m_ready = true;
}

template<typename particle_t, typename advancer_t>
inline void particle_system<particle_t, advancer_t>::advance()
{
	compute();

	thrust::for_each_n(thrust::device,
		thrust::make_zip_iterator(
			thrust::make_tuple(
				m_advancers.begin(), m_particles.begin(), m_forces.begin())),
		m_particles.size(),
		[] __device__(thrust::tuple<advancer_type&, particle_type&, force_type&> tpl)
		{
			thrust::get<0>(tpl)(thrust::get<1>(tpl), thrust::get<2>(tpl));
		});

	m_ready = false;
}

#endif