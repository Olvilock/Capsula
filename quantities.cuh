//Velocity, angular momentum, force, etc.

#pragma once
#include <vector_types.h>
#include <ostream>

using time_type = double;

//position and velocity types
using pos_type = double3;
using vel_type = double3;

//angular momentum type
//using mom_type = struct {};

//orientation(direction) type
//using dir_type = struct {};

//interaction type
struct force_type
{
	double3 force;
	//float3 momentum;

	__device__
		force_type& operator += (const force_type& other)
	{
		force.x += other.force.x;
		force.y += other.force.y;
		force.z += other.force.z;
		return *this;
	}
	__device__
		force_type& operator -= (const force_type& other)
	{
		force.x -= other.force.x;
		force.y -= other.force.y;
		force.z -= other.force.z;
		return *this;
	}
	__device__
		void reset()
	{
		force = { 0.0, 0.0, 0.0 };
	}
	friend std::ostream& operator <<(std::ostream& out, const force_type& to_out)
	{
		out << to_out.force.x << out.fill()
			<< to_out.force.y << out.fill()
			<< to_out.force.z << out.fill();
		return out;
	}
};