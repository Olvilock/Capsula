//Wall interaction

#pragma once

#include "quantities.cuh"
#include "particle.cuh"

namespace single
{
	enum class wall_family
	{
		straight,
		semisphere,
		sphere
	};

	template<wall_family w_id>
	struct wall_t
	{
		position_t m_pos;
		direction_t m_dir;

		using wall_id = w_id;
		using particle_type = particle;

		force_type force_on(const particle&);
	};
}