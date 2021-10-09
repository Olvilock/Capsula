#pragma once

#include <simple/advancer.cuh>
#include <simple/constants.cuh>
#include <simple/force.cuh>

namespace simple
{
	__device__
	void advancer_t::operator()
		(particle_t& ptc, force_t& frc)
	{
		frc.reset();
	}
}