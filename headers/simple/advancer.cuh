#pragma once

#include <particle_traits.cuh>
#include <advancer_traits.cuh>

#include "quantities.cuh"
#include "particle.cuh"

struct simple_advancer
{
	//calculate new state of particle_type
	//constants should reside in __constant__ memory of GPU
	__device__
	simple_particle operator()(const simple_particle& particle, simple_force& force);
};

template<>
struct advancer_traits<simple_advancer>
{
	using particle_type = simple_particle;
};