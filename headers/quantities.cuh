//Velocity, angular momentum, force, etc.

#pragma once

#include <vector_types.h>
#include <ostream>

using time_type = double;

//position and velocity types
using pos_type = double3;
using vel_type = double3;

//interaction type
struct force_type
{
	double3 force;

	__device__ force_type& operator += (const force_type& other);
	__device__ force_type& operator -= (const force_type& other);

	__device__ void reset();

	friend std::ostream& operator <<(std::ostream& out, const force_type& to_out);
};