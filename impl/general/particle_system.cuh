//Implementation of particle_system

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <general/particle_system.cuh>

#include <thrust/for_each.h>
#include <thrust/iterator/zip_iterator.h>
#include <thrust/execution_policy.h>

#ifdef __CUDACC__
template<typename particlce_t>
#else
template<proper_particle particlce_t>
#endif
particle_system<particlce_t>::particle_system(size_t size) :
	m_particles(size),
	m_forces(size),
	m_advancers(size)
{
	assert(size % BLK_SIZE<particle_type>() == 0);
}

#ifdef __CUDACC__
template<typename particlce_t>
#else
template<proper_particle particlce_t>
#endif
void particle_system<particlce_t>::compute()
{
	if (m_ready)
		return;

	assert(m_particles.size() % BLK_SIZE<particle_type>() == 0);

	unsigned blk_dim = m_particles.size() / BLK_SIZE<particle_type>();
	thrust::device_vector<unsigned> locks(blk_dim, blk_dim);

	normal_pairing<particle_type> <<< dim3(blk_dim, blk_dim), BLK_SIZE<particle_type>() >>>
		(thrust::raw_pointer_cast(m_particles.data()),
			thrust::raw_pointer_cast(m_forces.data()),
			thrust::raw_pointer_cast(locks.data()));

	m_ready = true;
}

#ifdef __CUDACC__
template<typename particlce_t>
#else
template<proper_particle particlce_t>
#endif
void particle_system<particlce_t>::advance()
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