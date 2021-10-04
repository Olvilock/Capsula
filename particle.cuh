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
	__device__
		force_type force_on(const particle& other);

	//calculate new state of particle after time_step
	//time_step will reside in __const__ memory of GPU
	__device__
		void advance(force_type force);
};