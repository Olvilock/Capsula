#pragma once

#include <simple/wall.cuh>

namespace simple
{
	Impulse Wall<WallFamily::plane>::force_on(const Particle& ptc)
	{
		if ((ptc.m_position - m_position) * m_direction > 0.0)
		{
			return (-ptc.m_velocity * m_direction) * m_direction;
		}
		return {};
	}
}