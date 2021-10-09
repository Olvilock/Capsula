#pragma once

#include <device_launch_parameters.h>
#include <simple/particle.cuh>
#include "constants.cuh"
#include "quantities.cuh"

namespace simple
{
	__device__
	force particle::force_on(const particle& other) const
	{
		pos_type relative_pos = other.m_position - m_position;
		// r^2
		double r_sq = sqr(relative_pos);
		// (sigma/r)^6
		double d = constants.sigma6 / (r_sq * r_sq * r_sq);
		return (constants._24epsilon * constants.sigma6 * d * (2*d - 1) / r_sq) * relative_pos;
	}
}
