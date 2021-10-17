#pragma once

#include <simple/particle.cuh>
#include <simple/constants.cuh>

namespace simple
{
	extern __constant__ Constant constants;

	__device__
	Force Particle::force_on(const Particle& other) const
	{
		auto relative_pos = other.m_position - m_position;
		// r^2
		double r_sq = relative_pos * relative_pos;
		// (sigma/r)^6
		double d = constants.par_sigma6 / (r_sq * r_sq * r_sq);
		return (constants.par_24epsilon * constants.par_sigma6 * d * (2*d - 1) / r_sq) * relative_pos;
	}
}
