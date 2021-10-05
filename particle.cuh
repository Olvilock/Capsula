//Particle properties & interaction

#pragma once
#include "quantities.cuh"

struct particle
{
	pos_type m_position;
	vel_type m_velocity;

	//Calculate force created ON other particle
	__device__ force_type force_on(const particle& other);

	//calculate new state of particle
	//constant.time_step will reside in __constant__ memory of GPU
	__device__ void advance(force_type force);
};

__device__
force_type particle::force_on(const particle& other)
{
	//TODO
	return { 1.0, 2.0, 3.0 };
}

__device__
void particle::advance(force_type force)
{
	//TODO
}
