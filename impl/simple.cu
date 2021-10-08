﻿//Implementation of simple

#include "general/particle_system.cuh"
#include "general/compute_all_forces.cuh"

#include "simple/quantities.cuh"
#include "simple/particle.cuh"
#include "simple/advancer.cuh"

#include <simple/particle_system.cuh>

namespace simple
{
	//Explicit instantiation definition
	template struct particle_system<particle>;
}