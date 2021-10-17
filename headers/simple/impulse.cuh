#pragma once

#include <device_launch_parameters.h>

#include "quantities.cuh"

namespace simple
{
	//wall interaction type
	struct Impulse
	{
		double3 m_impulse;

		Impulse() = default;
		__device__ __host__
			Impulse(const double3&);

		__device__ __host__ Impulse& operator += (const Impulse& other);
		__device__ __host__ void reset();

		friend std::ostream& operator <<(std::ostream& out, const Impulse& to_out);
	};
}