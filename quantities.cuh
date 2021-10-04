//Velocity, angular momentum, force, etc.

#pragma once
#include <vector_types.h>

using time_type = float;

//position and velocity types
using pos_type = float3;
using vel_type = float3;

//angular momentum type
//using mom_type = struct {};

//orientation(direction) type
//using dir_type = struct {};

//interaction type
struct force_type
{
	float3 force;

	__device__
		force_type& operator += (const force_type& other)
	{
		force.x += other.force.x;
		force.y += other.force.y;
		force.z += other.force.z;
		return *this;
	}
};