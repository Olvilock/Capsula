#pragma once

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include <thrust/transform.h>
#include <thrust/execution_policy.h>

#include <particle_advancer.cuh>
#include <compute_forces.cuh>

constexpr unsigned BLK_SIZE = 128;

template<typename particle, typename force>
class particle_system_template
{
	thrust::device_vector<particle> m_particles;
	thrust::device_vector<force> m_forces;
	particle_advancer_template<particle, force> m_advancer;
public:
	particle_system_template(size_t size);
	void advance();
	void compute();

	using particle_type = particle;
	using force_type = force;
};

//Specify template for code generation;
template class particle_system_template<particle_type, force_type>;

using particle_system = particle_system_template<particle_type, force_type>;