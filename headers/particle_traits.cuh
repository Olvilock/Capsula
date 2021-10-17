#pragma once

#include <concepts>

template<typename Particle>
struct particle_traits
{
	using force_type = Particle::force_type;
	using wallfrc_type = Particle::wallfrc_type;
};

#ifndef __CUDACC__

template<typename Particle>
concept proper_particle =
	std::default_initializable<typename particle_traits<Particle>::force_type> &&
	std::default_initializable<typename particle_traits<Particle>::wallfrc_type>;

#endif