//particle_type properties & interaction

#pragma once

#include <particle_traits.cuh>

#include "quantities.cuh"
#include "constants.cuh"

namespace simple
{
	struct particle
	{
		pos_type m_position;
		vel_type m_velocity;

		using force_type = force;
		using constant_type = constant;

		//Calculate force created ON other particle_type
		__device__ force force_on(const particle& other) const;
	};
}