#pragma once

#include <particle_traits.cuh>
#include <device_launch_parameters.h>

#ifdef __CUDACC__
template<typename particle_t>
#else
template<interactable_particle particle_t>
#endif
constexpr unsigned BLK_SIZE();

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only#ifdef __CUDACC__
#ifdef __CUDACC__
template<typename particle_t>
#else
template<interactable_particle particle_t>
#endif
__global__ void compute_interparticle_forces
(const particle_t* particles, force_type<particle_t>* forces, unsigned* locks);