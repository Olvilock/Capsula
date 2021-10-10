#pragma once

#include <simple/advancer.cuh>
#include <simple/force.cuh>
#include "constants.cuh"

namespace simple
{
	__device__
	void advancer_t::operator()
		(particle_t& ptc, force_t& frc)
	{
		ptc.m_position += constants.time_step * ptc.m_velocity;
		frc.reset();
	}
}