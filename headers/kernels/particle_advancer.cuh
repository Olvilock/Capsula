#pragma once

#include <device_launch_parameters.h>

#include <quantities.cuh>
#include <constants.cuh>
#include <particle.cuh>
#include <particle_advancer.cuh>

__device__
particle_type particle_advancer::operator()
	(const particle_type& particle, force_type& force)
{
	force.reset();
	return particle;
}