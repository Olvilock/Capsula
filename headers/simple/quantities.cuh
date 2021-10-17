//Types of position, velocity, angular momentum, etc.

#pragma once

#include <device_launch_parameters.h>

#include <vector_types.h>
#include <ostream>

namespace simple
{
	using time_t = double;

	using Position = double3;
	using PosDiff = double3;
	using Velocity = double3;
	using Direction = double3;

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