#pragma once

#include <concepts>
#include <particle_traits.cuh>

template<typename Advancer>
struct advancer_traits
{
	using particle_type = Advancer::particle_type;
	using force_type = Advancer::force_type;
};

#ifndef __CUDACC__

template<typename Advancer>
concept proper_advancer = proper_particle<typename advancer_traits<Advancer>::particle_type> &&
requires (Advancer & adv,
	typename advancer_traits<Advancer>::particle_type ptc,
	typename advancer_traits<Advancer>::force_type frc)
{
	{ frc += ptc.force_on(ptc) };
	{ adv(ptc, frc) };
};

#endif