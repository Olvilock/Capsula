#pragma once

#include <device_launch_parameters.h>
#include "simple/advancer.cuh"
#include "simple/constants.cuh"

namespace simple
{
	__device__
	particle advancer::operator()
		(const particle& ptc, force& frc)
	{
		frc.reset();
		return ptc;
	}
}