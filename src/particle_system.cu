//Implementation of particle_system

#include "particle_system.cuh"

__constant__ constant_type constants = { 0.0, 0.0, 0.0 };

particle_system::particle_system(size_t size) :
	m_particles(size),
	m_forces(size) {}

void particle_system::advance()
{
	assert(m_particles.size() == m_forces.size());

	thrust::transform(thrust::device,
		m_particles.cbegin(),
		m_particles.cend(),
		m_forces.begin(),
		m_particles.begin(),
		m_advancer);
}

void particle_system::compute()
{
	assert(m_particles.size() % BLK_SIZE == 0);
	assert(m_particles.size() == m_forces.size());

	unsigned blk_dim = m_particles.size() / BLK_SIZE;
	thrust::device_vector<unsigned> locks(blk_dim, blk_dim);

	interpar_compute <<< dim3(blk_dim, blk_dim), BLK_SIZE >>>
		(thrust::raw_pointer_cast(m_particles.data()),
			thrust::raw_pointer_cast(m_forces.data()),
			thrust::raw_pointer_cast(locks.data()));
}