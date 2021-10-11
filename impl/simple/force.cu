#pragma once

#include <simple/force.cuh>

namespace simple
{
	__device__ __host__
		force_t::force_t(const double3& d3) : m_force(d3) {}

	__device__ __host__
		force_t& force_t::operator += (const force_t& other)
	{
		m_force.x += other.m_force.x;
		m_force.y += other.m_force.y;
		m_force.z += other.m_force.z;
		return *this;
	}

	__device__ __host__
		void force_t::reset()
	{
		m_force = { 0.0, 0.0, 0.0 };
	}
}

//For dedugging reasons
std::ostream& operator <<(std::ostream& out, const simple::force_t& to_out)
{
	out << to_out.m_force.x << out.fill()
		<< to_out.m_force.y << out.fill()
		<< to_out.m_force.z;
	return out;
}