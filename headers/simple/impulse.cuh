#pragma once

#include "quantities.cuh"

namespace simple
{
	//wall interaction type
	struct impulse_t
	{
		double3 m_impulse;

		impulse_t() = default;
		__device__ __host__
			impulse_t(const double3&);

		__device__ __host__ impulse_t& operator += (const impulse_t& other);
		__device__ __host__ void reset();

		friend std::ostream& operator <<(std::ostream& out, const impulse_t& to_out);
	};
}