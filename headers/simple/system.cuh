#pragma once

#include <general/system.cuh>

#include "particle.cuh"
#include "advancer.cuh"

namespace simple
{
	using System = general::System<Particle, Advancer>;

	//Explicit instantiation declaration
	extern template struct general::System<Particle, Advancer>;
}