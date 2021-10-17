#pragma once

#include <simple/advancer.cuh>
#include <simple/constants.cuh>
#include <simple/force.cuh>

namespace simple
{
	extern __constant__ Constant constants;

	__device__
		void Advancer::operator()
		(Particle& ptc, Force& frc)
	{
		ptc.m_position += constants.time_step * ptc.m_velocity;
		frc.reset();
	}
}