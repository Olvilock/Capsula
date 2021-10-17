//Wall interaction

#pragma once

#include "quantities.cuh"
#include "impulse.cuh"
#include "particle.cuh"

namespace simple
{
	enum class WallFamily
	{
		any,
		plane,
		semisphere,
		sphere
	};

	template<WallFamily>
	struct Wall;

	template<> struct Wall<WallFamily::any>
	{
		virtual Impulse force_on(const Particle&);
	};

	template<WallFamily w_id>
	struct Wall final : Wall<WallFamily::any>
	{
		Position m_position;
		Direction m_direction;

		using particle_type = Particle;

		Impulse force_on(const Particle&) final;
	};
}