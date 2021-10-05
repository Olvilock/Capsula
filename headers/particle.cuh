//particle_type properties & interaction

#pragma once
#include <quantities.cuh>

struct particle_type
{
	pos_type m_position;
	vel_type m_velocity;

	//Calculate force created ON other particle_type
	__device__ force_type force_on(const particle_type& other) const;
};
