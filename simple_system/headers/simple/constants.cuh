#pragma once

#include "quantities.cuh"

namespace simple
{
	struct constant
	{
		simple::time_type time_step;
		double epsilon12; //12 * epsilon
		double sigma3; //sigma ^ 3
	};
}
