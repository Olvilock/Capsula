#pragma once

#include <device_launch_parameters.h>
#include "..\particle.cuh"

namespace simple
{
	__device__
	force particle::force_on(const particle& other) const
	{
		/*
		pos_type relativePos = other.m_position - m_position;
		// r^2
		double rSq = relativePos.x * relativePos.x + relativePos.y * relativePos.y + relativePos.z * relativePos.z; //!!
		// 1/r
		double rr = rsqrt(rSq);
		// (sigma/r)^3
		double d = constants.sigma3 / rr * rSq;
		return (constants.epsilon12 / rSq * d * (2d - 1)) * relativePos;
		*/

		//For initial debugging
		return { 1.0, 2.0, 3.0 };
	}
}
