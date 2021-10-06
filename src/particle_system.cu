//Implementation of particle_system

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <particle_system.cuh>
#include <LIBS.cuh>

template</*particle*/ typename particle_t, /*advancer*/ typename advancer_t>
particle_system<particle_t, advancer_t>::particle_system(size_t size) :
	m_particles(size),
	m_forces(size) {}

template</*particle*/ typename particle_t, /*advancer*/ typename advancer_t>
void particle_system<particle_t, advancer_t>::compute()
{
	assert(m_particles.size() % BLK_SIZE == 0);
	assert(m_particles.size() == m_forces.size());

	unsigned blk_dim = m_particles.size() / BLK_SIZE;
	thrust::device_vector<unsigned> locks(blk_dim, blk_dim);

	std::lock_guard<std::mutex> lock_system(m_mutex);

	compute_interparticle_forces<particle_t> <<< dim3(blk_dim, blk_dim), BLK_SIZE >>>
		(thrust::raw_pointer_cast(m_particles.data()),
			thrust::raw_pointer_cast(m_forces.data()),
			thrust::raw_pointer_cast(locks.data()));
}

template</*particle*/ typename particle_t, /*advancer*/ typename advancer_t>
void particle_system<particle_t, advancer_t>::advance()
{
	assert(m_particles.size() == m_forces.size());

	std::lock_guard<std::mutex> lock_system(m_mutex);

	thrust::transform(thrust::device,
		m_particles.cbegin(),
		m_particles.cend(),
		m_forces.begin(),
		m_particles.begin(),
		m_advancer);
}
