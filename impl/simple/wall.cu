#pragma once

#include <simple/wall.cuh>

namespace simple
{
	impulse_t wall_t<wall_family::plane>::force_on(const particle_t& ptc)
	{
		if ((ptc.m_position - m_position) * m_direction > 0.0)
		{
			return (-ptc.m_velocity * m_direction) * m_direction;
		}
		return {};
	}
}