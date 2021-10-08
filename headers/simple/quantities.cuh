//Velocity, angular momentum, force, etc.

#pragma once

#include <vector_types.h>
#include <ostream>

namespace simple
{
	using time_type = double;

	//position and velocity types
	using pos_type = double3;
	using vel_type = double3;

	//direction type
	using dir_type = double3;

	//interaction type
	struct force
	{
		double3 frc;

		force() = default;

		__device__
		force(const double3&);

		__device__ force& operator -= (const force& other);
		__device__ force& operator += (const force& other);

		__device__ void reset();

		friend std::ostream& operator <<(std::ostream& out, const force& to_out);
	};
}