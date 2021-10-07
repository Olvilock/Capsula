//Implementation of simple

#include <default/impl/particle_system.cuh>
#include <default/impl/compute_all_forces.cuh>

#include "impl/quantities.cuh"
#include "impl/particle.cuh"
#include "impl/advancer.cuh"

#include <simple/particle_system.cuh>

namespace simple
{
	//Specify template for code generation;
	template struct particle_system<particle, advancer>;
}