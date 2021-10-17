//particle_type properties & interaction

#pragma once

#include <device_launch_parameters.h>

#include "quantities.cuh"
#include "force.cuh"
#include "impulse.cuh"

namespace simple
{
	struct Particle
	{
		Position m_position;
		Velocity m_velocity;

		using force_type = Force;
		using wallfrc_type = Impulse;

		//Calculate force created ON other particle_type
		__device__ Force force_on(const Particle& other) const;
	};
}