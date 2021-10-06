#pragma once

#include <particle_system.cuh>

#include "particle.cuh"
#include "advancer.cuh"

//Specify template for code generation;
template struct particle_system<simple_particle, simple_advancer>;

using simple_system = particle_system<simple_particle, simple_advancer>;
