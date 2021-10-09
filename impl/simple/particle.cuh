#pragma once

#include <simple/particle.cuh>

#include "constants.cuh"

namespace simple
{
	__device__
	force_t particle_t::force_on(const particle_t& other) const
	{
		auto relative_pos = other.m_position - m_position;
		// r^2
		double r_sq = relative_pos * relative_pos;
		// (sigma/r)^6
		double d = constants.sigma6 / (r_sq * r_sq * r_sq);
		return (constants._24epsilon * constants.sigma6 * d * (2*d - 1) / r_sq) * relative_pos;
	}
}
