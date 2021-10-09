#pragma once

#include "quantities.cuh"

namespace simple
{
	//interaction type
	struct force_t
	{
		double3 m_force;

		force_t() = default;
		__device__ __host__
			force_t(const double3&);

		__device__ __host__ force_t& operator += (const force_t& other);
		__device__ __host__ void reset();

		friend std::ostream& operator <<(std::ostream& out, const force_t& to_out);
	};
}