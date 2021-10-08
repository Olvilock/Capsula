#pragma once

#include <general/particle_system.cuh>

#include "particle.cuh"
#include "advancer.cuh"

namespace simple
{
	using system = particle_system<particle>;
}
