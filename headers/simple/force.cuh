//Interparticle interaction type

#pragma once

#include <device_launch_parameters.h>

#include "quantities.cuh"

namespace simple
{
	//interaction type
	struct Force
	{
		double3 m_force;

		Force() = default;
		__device__ __host__
			Force(const double3&);

		__device__ __host__ Force& operator += (const Force& other);
		__device__ __host__ void reset();

		friend std::ostream& operator <<(std::ostream& out, const Force& to_out);
	};
}