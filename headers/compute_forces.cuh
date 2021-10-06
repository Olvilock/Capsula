#pragma once

#include <device_launch_parameters.h>

#include <particle_traits.cuh>

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
template</*particle*/typename particle_t>
__global__ void compute_interparticle_forces
(const particle_t* particles, force_type<particle_t>* forces, unsigned* locks);