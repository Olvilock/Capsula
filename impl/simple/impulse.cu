#pragma once

#include <simple/impulse.cuh>

namespace simple
{
	__device__ __host__
		impulse_t::impulse_t(const double3& d3) : m_impulse(d3) {}

	__device__ __host__
		impulse_t& impulse_t::operator += (const impulse_t& other)
	{
		m_impulse.x += other.m_impulse.x;
		m_impulse.y += other.m_impulse.y;
		m_impulse.z += other.m_impulse.z;
		return *this;
	}

	__device__ __host__
		void impulse_t::reset()
	{
		m_impulse = { 0.0, 0.0, 0.0 };
	}
}

//For dedugging reasons
std::ostream& operator <<(std::ostream& out, const simple::impulse_t& to_out)
{
	out << to_out.m_impulse.x << out.fill()
		<< to_out.m_impulse.y << out.fill()
		<< to_out.m_impulse.z;
	return out;
}