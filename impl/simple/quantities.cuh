#pragma once

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <simple/quantities.cuh>

namespace simple
{
	__device__
		double sqr(const double3& val)
	{
		return val.x * val.x + val.y * val.y + val.z * val.z;
	}
	__device__
		double3 operator -(const double3& one, const double3& other)
	{
		return { one.x - other.x, one.y - other.y, one.z - other.z };
	}

	__device__
		double3 operator *(const double& scalar, const double3& vector)
	{
		return { scalar * vector.x, scalar * vector.y, scalar * vector.z };
	}
}