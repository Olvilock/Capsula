#pragma once

#include "quantities.cuh"

struct constant_type
{
	time_type time_step = 1e-5;
};

__constant__ constant_type constants;
