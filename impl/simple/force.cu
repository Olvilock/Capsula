#pragma once

#include <simple/force.cuh>

namespace simple
{
	__device__ __host__
		Force::Force(const double3& d3) : m_force(d3) {}

	__device__ __host__
		Force& Force::operator += (const Force& other)
	{
		m_force.x += other.m_force.x;
		m_force.y += other.m_force.y;
		m_force.z += other.m_force.z;
		return *this;
	}

	__device__ __host__
		void Force::reset()
	{
		m_force = { 0.0, 0.0, 0.0 };
	}
}

//For dedugging reasons
std::ostream& operator <<(std::ostream& out, const simple::Force& to_out)
{
	out << to_out.m_force.x << out.fill()
		<< to_out.m_force.y << out.fill()
		<< to_out.m_force.z;
	return out;
}