//Particle properties & interaction

#pragma once
#include "quantities.cuh"

struct particle
{
	pos_type m_position;
	vel_type m_velocity;
	//mom_type m_momentum;
	//dir_type m_direction;

	//Calculate force created ON other particle
	__device__ force_type force_on(const particle& other);

	//calculate new state of particle after time_step
	//time_step will reside in __const__ memory of GPU
	__device__ void advance(force_type force);
};

__device__
force_type particle::force_on(const particle& other)
{
	//TODO
	return { 1.0, 2.0, 3.0 };
}

//__constant__ time_type time_step = 1.0e-4;

__device__
void particle::advance(force_type force)
{
	//TODO
}
