#pragma once

#include <concepts>

template<typename particle_t>
struct particle_traits
{
	using force_type = particle_t::force_type;
	using wallfrc_type = particle_t::wallfrc_type;
};

#ifndef __CUDACC__

template<typename particle_t>
concept proper_particle =
	std::default_initializable<typename particle_traits<particle_t>::force_type> &&
	std::default_initializable<typename particle_traits<particle_t>::wallfrc_type>;

#endif