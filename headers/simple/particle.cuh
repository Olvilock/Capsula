//particle_type properties & interaction

#pragma once

#include "quantities.cuh"
#include "advancer.cuh"

namespace simple
{
	struct particle
	{
		pos_type m_position;
		vel_type m_velocity;

		using force_type = force;
		using advancer_type = advancer;

		//Calculate force created ON other particle_type
		__device__ force force_on(const particle& other) const;
	};
}