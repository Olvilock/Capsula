#pragma once

#include "quantities.cuh"

namespace simple
{
	struct constant_t
	{
		simple::time_t time_step;
		
		//24 * epsilon
		double _24epsilon; 
		
		//sigma ^ 6
		double sigma6; 
	};
}
