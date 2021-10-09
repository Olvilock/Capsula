#pragma once

#include <particle_traits.cuh>
#include <device_launch_parameters.h>

#ifdef __CUDACC__
template<typename particle_t>
#else
template<proper_particle particle_t>
#endif
constexpr unsigned BLK_SIZE();

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only#ifdef __CUDACC__
#ifdef __CUDACC__
template<typename particle_t>
#else
template<proper_particle particle_t>
#endif
__global__ void normal_pairing
	(const particle_t*, typename particle_traits<particle_t>::force_type*, unsigned*);