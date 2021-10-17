//Implementation of simple::System

#include <simple/system.cuh>

namespace simple
{
	//Explicit instantiation definition
	template struct general::System<Particle, Advancer>;
}