#pragma once

#include <simple/constants.cuh>

namespace simple
{
	__device__ __constant__
	Constant constants = { 0.0, 0.0, 0.0 };
}