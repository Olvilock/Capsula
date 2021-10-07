#pragma once

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <simple/quantities.cuh>

namespace simple
{
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

	__device__
		force& force::operator += (const force& other)
	{
		frc.x += other.frc.x;
		frc.y += other.frc.y;
		frc.z += other.frc.z;
		return *this;
	}

	__device__
		force& force::operator -= (const force& other)
	{
		frc.x -= other.frc.x;
		frc.y -= other.frc.y;
		frc.z -= other.frc.z;
		return *this;
	}

	__device__
		void force::reset()
	{
		frc = { 0.0, 0.0, 0.0 };
	}
}

//For dedugging reasons
std::ostream& operator <<(std::ostream& out, const simple::force& to_out)
{
	out << to_out.frc.x << out.fill()
		<< to_out.frc.y << out.fill()
		<< to_out.frc.z;
	return out;
}