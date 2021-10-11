//Implementation of simple::particle_system

#include <simple/particle_system.cuh>

namespace simple
{
	//Explicit instantiation definition
	template struct particle_system<particle_t, advancer_t>;
}