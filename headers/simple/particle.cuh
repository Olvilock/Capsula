//particle_type properties & interaction

#pragma once

#include <device_launch_parameters.h>

#include "quantities.cuh"
#include "force.cuh"
#include "impulse.cuh"
#include "advancer.cuh"

namespace simple
{
	struct particle_t
	{
		position_t m_position;
		velocity_t m_velocity;

		using force_type = force_t;
		using wallfrc_type = impulse_t;
		using advancer_type = advancer_t;

		//Calculate force created ON other particle_type
		__device__ force_t force_on(const particle_t& other) const;
	};
}