#pragma once

#include <device_launch_parameters.h>

#include "force.cuh"
#include "particle.cuh"

namespace simple
{
	struct Advancer
	{
		using particle_type = Particle;
		using force_type = Force;

		//calculate new state of particle
		//constants should reside in __constant__ memory of GPU
		__device__ void operator()(Particle&, Force&);
	};
}