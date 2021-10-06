#pragma once

// #include <concepts>

template<typename particle_t>
struct particle_traits;

template<typename particle_t>
using force_type = typename particle_traits<particle_t>::force_type;

template<typename particle_t>
using constant_type = typename particle_traits<particle_t>::constant_type;

/*
template<typename particle_t>
concept particle = 
	std::copy_constructible<constant_type<particle_t> > &&
	std::default_initializable<force_type<particle_t> > &&
	requires(force_type<particle_t> a, force_type<particle_t> b)
	{
		{ a += b } -> std::same_as<force_type<particle_t> &>;
	};
*/