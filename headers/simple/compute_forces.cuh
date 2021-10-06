#pragma once

#include <compute_forces.cuh>
#include "particle.cuh"

//Explicit instantiation
template
__global__ void compute_interparticle_forces<simple_particle>
(const simple_particle* particles, simple_force* forces, unsigned* locks);