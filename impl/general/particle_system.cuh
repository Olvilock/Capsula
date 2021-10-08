//Implementation of particle_system

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <general/particle_system.cuh>

#ifdef __CUDACC__
template<typename particlce_t>
#else
template<proper_particle particlce_t>
#endif
particle_system<particlce_t>::particle_system(size_t size) :
	m_particles(size),
	m_forces(size) {}

#ifdef __CUDACC__
template<typename particlce_t>
#else
template<proper_particle particlce_t>
#endif
void particle_system<particlce_t>::compute()
{
	/*if (m_ready)
		return;*/

	assert(m_particles.size() % BLK_SIZE<particle_type>() == 0);

	unsigned blk_dim = m_particles.size() / BLK_SIZE<particle_type>();
	thrust::device_vector<unsigned> locks(blk_dim, blk_dim);

	compute_interparticle_forces<particle_type> <<< dim3(blk_dim, blk_dim), BLK_SIZE<particle_type>() >>>
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

	thrust::transform(thrust::device,
		m_particles.cbegin(),
		m_particles.cend(),
		m_forces.begin(),
		m_particles.begin(),
		m_advancer);

	m_ready = false;
}