﻿//Implementation of simple

#include "general/particle_system.cuh"
#include "general/normal_pairing.cuh"

#include "simple/particle.cuh"
#include <simple/particle_system.cuh>

namespace simple
{
	//Explicit instantiation definition
	template struct particle_system<particle_t>;
}