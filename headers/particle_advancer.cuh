#pragma once

#include "particle.cuh"

struct particle_advancer
{
	//calculate new state of particle_type
	//constant.time_step will reside in __constant__ memory of GPU
	__device__
	particle_type operator()(const particle_type& particle, force_type& force);
};
