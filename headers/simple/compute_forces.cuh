#pragma once

#include <compute_forces.cuh>
#include "particle.cuh"

//Explicit instantiation
template
__global__ void compute_interparticle_forces<simple::particle>
(const simple::particle* particles, simple::force* forces, unsigned* locks);