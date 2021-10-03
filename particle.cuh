//Particle properties & interaction

#pragma once
#include "quantities.cuh"

__device__
struct particle
{
	pos_type m_position;
	vel_type m_velocity;
	mom_type m_momentum;
	dir_type m_direction;
	// and maybe orientation & angular momentum in the future

	//Calculate force created ON other particle
	__device__ __inline__
		inter_type force_on(const particle& other);

	__device__ __inline__
		void advance(inter_type force);
	//time_step will reside in __const__ memory of GPU
};