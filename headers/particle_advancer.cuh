#pragma once

#include <particle.cuh>

template<typename particle, typename force>
struct particle_advancer_template
{
	//calculate new state of particle_type
	//constants should reside in __constant__ memory of GPU
	__device__
	particle_type operator()(const particle& particle, force& force);
};

using particle_advancer = particle_advancer_template<particle_type, force_type>;