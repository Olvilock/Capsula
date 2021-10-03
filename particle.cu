//particle implementation

#include "particle.cuh"

__device__ __inline__
inter_type particle::force_on(const particle& other)
{
	//TODO
	return inter_type();
}

extern __constant__ time_type time_step;

void particle::advance(inter_type force)
{
	//TODO
}
