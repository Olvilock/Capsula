//particle_type properties & interaction

#pragma once

#include <particle_traits.cuh>

#include "quantities.cuh"
#include "constants.cuh"

struct simple_particle
{
	pos_type m_position;
	vel_type m_velocity;

	using constant_type = simple_constant;
	using force_type = constant_type;

	//Calculate force created ON other particle_type
	__device__ simple_force force_on(const simple_particle& other) const;
};

template<>
struct particle_traits<simple_particle>
{
	using force_type = simple_force;
	using constant_type = simple_constant;
};