#pragma once

#include <concepts>

template<typename particle_t>
struct particle_traits
{
	using force_type = particle_t::force_type;
	using advancer_type = particle_t::advancer_type;
};

template<typename particle_t>
using force_t = typename particle_traits<particle_t>::force_type;

template<typename particle_t>
using advancer_t = typename particle_traits<particle_t>::advancer_type;

#ifndef __CUDACC__

template<typename particle_t>
concept proper_particle = 
	std::default_initializable<force_t<particle_t> > &&
	requires (particle_t& ptc, force_t<particle_t> frc, advancer_t<particle_t> adv)
	{
		{ frc += frc } -> std::same_as<force_t<particle_t>&>;
		{ adv(ptc, frc) } -> std::same_as<particle_t>;
	};

#endif