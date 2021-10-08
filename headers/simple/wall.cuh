//Wall interaction

#pragma once

#include "quantities.cuh"
#include "particle.cuh"

namespace single
{
	enum class wall_type
	{
		straight,
		semisphere,
		sphere
	};

	template<wall_type w_id>
	struct wall
	{
		pos_type m_pos;
		dir_type m_dir;

		using wall_id = w_id;
		using particle_type = particle;

		force_type force_on(const particle&);
	};
}