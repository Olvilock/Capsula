#pragma once

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <quantities.cuh>
#include <particle.cuh>

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
force_type& force_type::operator += (const force_type& other)
{
	force.x += other.force.x;
	force.y += other.force.y;
	force.z += other.force.z;
	return *this;
}

__device__
force_type& force_type::operator -= (const force_type& other)
{
	force.x -= other.force.x;
	force.y -= other.force.y;
	force.z -= other.force.z;
	return *this;
}

__device__
void force_type::reset()
{
	force = { 0.0, 0.0, 0.0 };
}

//For dedugging reasons
std::ostream& operator <<(std::ostream& out, const force_type& to_out)
{
	out << to_out.force.x << out.fill()
		<< to_out.force.y << out.fill()
		<< to_out.force.z;
	return out;
}