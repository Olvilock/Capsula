#ifndef NAME
#error "Put the framework name to the NAME macro before including kernels.cuh"
#endif

#define INCLUDE(name) <name.cuh>

#include INCLUDE(NAME/quantities)
#include INCLUDE(NAME/constants)
#include INCLUDE(NAME/particle)
#include INCLUDE(NAME/advancer)

#ifdef KERNELS

#include INCLUDE(NAME/kernels/quantities)
#include INCLUDE(NAME/kernels/constants)
#include INCLUDE(NAME/kernels/particle)
#include INCLUDE(NAME/kernels/advancer)

#endif

#include INCLUDE(NAME/particle_system)
#include INCLUDE(NAME/compute_forces)

#undef INCLUDE
#undef NAME