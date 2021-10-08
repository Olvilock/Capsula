#pragma once

#include "quantities.cuh"
#include "particle.cuh"

namespace simple
{
	struct particle;
	struct advancer
	{
		//calculate new state of particle_type
		//constants should reside in __constant__ memory of GPU
		__device__
			particle operator()(const particle&, force&);
	};
}