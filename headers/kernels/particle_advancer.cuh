#pragma once

__device__
particle_type particle_advancer::operator()(const particle_type& particle, force_type& force)
{
	force.reset();
	return particle;
}