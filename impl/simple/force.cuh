#pragma once

#include <simple/force.cuh>

namespace simple
{
	__device__
		force_t::force_t(const double3& d3) : frc(d3) {}

	__device__
		force_t& force_t::operator += (const force_t& other)
	{
		frc.x += other.frc.x;
		frc.y += other.frc.y;
		frc.z += other.frc.z;
		return *this;
	}

	__device__
		void force_t::reset()
	{
		frc = { 0.0, 0.0, 0.0 };
	}
}

//For dedugging reasons
std::ostream& operator <<(std::ostream& out, const simple::force_t& to_out)
{
	out << to_out.frc.x << out.fill()
		<< to_out.frc.y << out.fill()
		<< to_out.frc.z;
	return out;
}