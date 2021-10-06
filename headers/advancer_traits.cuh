#pragma once

// #include <concepts>
#include <particle_traits.cuh>

template<typename advancer_t>
struct advancer_traits;

template<typename advancer_t>
using particle_type = typename advancer_traits<advancer_t>::particle_type;

/*
template<typename advancer_t>
concept advancer = particle<particle_type<advancer_t> >
	&& requires (advancer_t adv,
				 const particle_type<advancer_t>& ptc,
				 force_type<particle_type<advancer_t> > frc)
	{
		{ adv(ptc, frc) } -> std::same_as<particle_type<advancer_t> >;
	};
*/