#pragma once

#include <concepts>
#include <particle_traits.cuh>

template<typename advancer_t>
struct advancer_traits
{
	using particle_type = advancer_t::particle_type;
	using force_type = advancer_t::force_type;
};

#ifndef __CUDACC__

template<typename advancer_t>
concept proper_advancer = proper_particle<typename advancer_traits<advancer_t>::particle_type> &&
requires (advancer_t & adv,
	typename advancer_traits<advancer_t>::particle_type ptc,
	typename advancer_traits<advancer_t>::force_type frc)
{
	{ frc += ptc.force_on(ptc) };
	{ adv(ptc, frc) };
};

#endif