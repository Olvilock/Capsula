//Velocity, angular momentum, force, etc.

#pragma once

#include <vector_types.h>
#include <ostream>

using time_type = double;

//position and velocity types
using pos_type = double3;
using vel_type = double3;

//interaction type
struct simple_force
{
	double3 force;

	__device__ simple_force& operator += (const simple_force& other);
	__device__ simple_force& operator -= (const simple_force& other);

	__device__ void reset();

	friend std::ostream& operator <<(std::ostream& out, const simple_force& to_out);
};