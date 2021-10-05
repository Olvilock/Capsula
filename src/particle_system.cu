//Implementation of particle_system_template

#include <constants.cuh>
#include <particle_system.cuh>

__constant__ constant_type constants = { 0.0, 0.0, 0.0 };

template<typename particle, typename force>
particle_system_template<particle, force>::particle_system_template(size_t size) :
	m_particles(size),
	m_forces(size) {}

template<typename particle, typename force>
void particle_system_template<particle, force>::advance()
{
	assert(m_particles.size() == m_forces.size());

	thrust::transform(thrust::device,
		m_particles.cbegin(),
		m_particles.cend(),
		m_forces.begin(),
		m_particles.begin(),
		m_advancer);
}

template<typename particle, typename force>
void particle_system_template<particle, force>::compute()
{
	assert(m_particles.size() % BLK_SIZE == 0);
	assert(m_particles.size() == m_forces.size());

	unsigned blk_dim = m_particles.size() / BLK_SIZE;
	thrust::device_vector<unsigned> locks(blk_dim, blk_dim);

	compute_interparticle_forces<particle, force> <<< dim3(blk_dim, blk_dim), BLK_SIZE >>>
		(thrust::raw_pointer_cast(m_particles.data()),
			thrust::raw_pointer_cast(m_forces.data()),
			thrust::raw_pointer_cast(locks.data()));
}