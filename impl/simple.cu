//Implementation of simple

#include "general/particle_system.cuh"
#include "general/normal_pairing.cuh"

#include "simple/quantities.cuh"
#include "simple/constants.cuh"
#include "simple/force.cuh"
#include "simple/wallfrc.cuh"
#include "simple/particle.cuh"
#include "simple/wall.cuh"
#include "simple/advancer.cuh"

#include <simple/particle_system.cuh>

namespace simple
{
	//Explicit instantiation definition
	template struct particle_system<particle_t>;
}