#pragma once

#include <default/particle_system.cuh>
#include <default/compute_all_forces.cuh>

#include "particle.cuh"
#include "advancer.cuh"

namespace simple
{
	using system = particle_system<particle, advancer>;
}
