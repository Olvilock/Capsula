#ifndef LIB_NAME
#error "Put the framework LIB_NAME to the LIB_NAME macro before including kernels.cuh"
#endif

#define LIB_INCLUDE(LIB_NAME) <LIB_NAME.cuh>

#ifdef KERNELS

#include LIB_INCLUDE(LIB_NAME/kernels/quantities)
#include LIB_INCLUDE(LIB_NAME/kernels/constants)
#include LIB_INCLUDE(LIB_NAME/kernels/particle)
#include LIB_INCLUDE(LIB_NAME/kernels/advancer)

#include LIB_INCLUDE(LIB_NAME/compute_forces)

#else 

#include LIB_INCLUDE(LIB_NAME/particle_system)

#endif

#undef LIB_INCLUDE
#undef LIB_NAME