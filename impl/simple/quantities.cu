#pragma once

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <simple/quantities.cuh>

namespace simple
{
	__device__ __host__
		double3 operator -(const double3& value)
	{
		return { -value.x, -value.y, -value.z };
	}

	__device__ __host__
		double3 operator -(const double3& one, const double3& other)
	{
		return { one.x - other.x, one.y - other.y, one.z - other.z };
	}

	__device__ __host__
		double3 operator *(const double& scalar, const double3& vector)
	{
		return { scalar * vector.x, scalar * vector.y, scalar * vector.z };
	}

	__device__ __host__
		double operator *(const double3& one, const double3& other)
	{
		return one.x * other.x + one.y * other.y + one.z * other.z;
	}

	__device__ __host__
		double3& operator +=(double3& value, const double3& diff)
	{
		value.x += diff.x;
		value.y += diff.y;
		value.z += diff.z;
		return value;
	}
}