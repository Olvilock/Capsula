#pragma once

#include <simple/advancer.cuh>
#include <simple/constants.cuh>
#include <simple/force.cuh>

namespace simple
{
	extern __constant__ constant_t constants;

	__device__
		void advancer_t::operator()
		(particle_t& ptc, force_t& frc)
	{
		ptc.m_position += constants.time_step * ptc.m_velocity;
		frc.reset();
	}
}