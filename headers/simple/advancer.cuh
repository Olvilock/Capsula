#pragma once

#include <particle_traits.cuh>
#include <advancer_traits.cuh>

#include "quantities.cuh"
#include "particle.cuh"

namespace simple
{
	struct advancer
	{
		//calculate new state of particle_type
		//constants should reside in __constant__ memory of GPU
		__device__
			particle operator()(const particle&, force&);
	};
}

template<>
struct advancer_traits<simple::advancer>
{
	using particle_type = simple::particle;
};