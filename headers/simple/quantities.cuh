//Velocity, angular momentum, force, etc.

#pragma once

#include <vector_types.h>
#include <ostream>

namespace simple
{
	using time_t = double;

	using position_t = double3;
	using posdiff_t = double3;
	using velocity_t = double3;
	using direction_t = double3;

	__device__ __host__
		double3 operator -(const double3&);

	__device__ __host__
		double3 operator -(const double3&, const double3&);

	__device__ __host__
		double3 operator *(const double&, const double3&);

	__device__ __host__
		double operator *(const double3&, const double3&);

	__device__ __host__
		double3& operator +=(double3&, const double3&);
}