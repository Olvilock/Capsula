#pragma once

#include "quantities.cuh"

namespace simple
{
	struct constant
	{
		simple::time_type time_step;
		double _24epsilon; //24 * epsilon
		double sigma6; //sigma ^ 6
	};
}
