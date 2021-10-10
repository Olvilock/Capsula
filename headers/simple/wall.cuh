//Wall interaction

#pragma once

#include "quantities.cuh"
#include "impulse.cuh"
#include "particle.cuh"

namespace simple
{
	enum class wall_family
	{
		any,
		plane,
		semisphere,
		sphere
	};

	template<wall_family>
	struct wall_t;

	template<> struct wall_t<wall_family::any>
	{
		virtual impulse_t force_on(const particle_t&);
	};

	template<wall_family w_id>
	struct wall_t final : wall_t<wall_family::any>
	{
		position_t m_position;
		direction_t m_direction;

		using particle_type = particle_t;

		impulse_t force_on(const particle_t&) final;
	};
}