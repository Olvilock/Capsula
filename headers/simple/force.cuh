#pragma once

#include "quantities.cuh"

namespace simple
{
	//interaction type
	struct force_t
	{
		double3 frc;

		force_t() = default;

		__device__
			force_t(const double3&);

		__device__ force_t& operator += (const force_t& other);

		__device__ void reset();

		friend std::ostream& operator <<(std::ostream& out, const force_t& to_out);
	};
}