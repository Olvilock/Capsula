#pragma once

#include <general/particle_system.cuh>

#include "particle.cuh"
#include "advancer.cuh"

namespace simple
{
	using system = particle_system<particle_t, advancer_t>;

	//Explicit instantiation declaration
	extern template struct particle_system<particle_t, advancer_t>;
}
