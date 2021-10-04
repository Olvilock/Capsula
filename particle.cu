//particle implementation

#include "particle.cuh"

__device__
force_type particle::force_on(const particle& other)
{
	//TODO
	return force_type();
}

//__constant__ time_type time_step = 1.0e-4;

__device__
void particle::advance(force_type force)
{
	//TODO
}
