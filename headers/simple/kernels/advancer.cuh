#pragma once

#include <device_launch_parameters.h>
#include "..\advancer.cuh"
#include "..\constants.cuh"

__device__
simple_particle simple_advancer::operator()
	(const simple_particle& particle, simple_force& force)
{
	force.reset();
	return particle;
}