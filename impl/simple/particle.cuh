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
		pos_type relativePos = other.m_position - m_position;
		// r^2
		double rSq = sqr(relativePos);
		// (sigma/r)^6
		double d = constants.sigma6 / (rSq * rSq * rSq);
		return (constants.epsilon24 * constants.sigma6 * d * (2*d - 1) / rSq) * relativePos;
	}
}
