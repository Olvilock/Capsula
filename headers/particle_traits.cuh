#pragma once

#include <concepts>

template<typename particle_t>
struct particle_traits
{
	using force_type = particle_t::force_type;
	using advancer_type = particle_t::advancer_type;
};

#ifndef __CUDACC__

template<typename particle_t>
concept proper_particle =
	std::default_initializable<typename particle_traits<particle_t>::force_type> &&
	requires (particle_t& ptc,
		typename particle_traits<particle_t>::force_type frc,
		typename particle_traits<particle_t>::advancer_type adv)
	{
		{ frc += ptc.force_on(ptc) };
		{ adv(ptc, frc) };
	};

#endif