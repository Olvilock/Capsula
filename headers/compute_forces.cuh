#pragma once

#include <device_launch_parameters.h>

#include <particle.cuh>
#include <quantities.cuh>

//Call with 1-dimensional block with blockDim.x == BLK_SIZE only
template<typename particle, typename force>
__global__ void compute_interparticle_forces(const particle* particles, force* forces, unsigned* locks);

template
__global__ void compute_interparticle_forces<particle_type, force_type>
	(const particle_type* particles, force_type* forces, unsigned* locks);