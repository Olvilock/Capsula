#pragma once

#include <device_launch_parameters.h>

#include "force.cuh"
#include "particle.cuh"

namespace simple
{
	struct advancer_t
	{
		//calculate new state of particle
		//constants should reside in __constant__ memory of GPU
		__device__ void operator()(particle_t&, force_t&);
	};
}