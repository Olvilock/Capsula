#pragma once

#include "quantities.cuh"

namespace simple
{
	//wall interaction type
	struct wallfrc_t
	{
		double3 m_impulse;

		wallfrc_t() = default;
		__device__ __host__
			wallfrc_t(const double3&);

		__device__ __host__ wallfrc_t& operator += (const wallfrc_t& other);
		__device__ __host__ void reset();

		friend std::ostream& operator <<(std::ostream& out, const wallfrc_t& to_out);
	};
}