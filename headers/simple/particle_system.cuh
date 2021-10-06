#pragma once

#include <particle_system.cuh>

#include "particle.cuh"
#include "advancer.cuh"

namespace simple
{
	//Specify template for code generation;
	template struct particle_system<particle, advancer>;

	using system = particle_system<particle, advancer>;
}
