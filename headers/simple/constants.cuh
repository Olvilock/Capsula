#pragma once

#include "quantities.cuh"

namespace simple
{
	struct Constant
	{
		simple::time_t time_step;
		
		//24 * epsilon
		double par_24epsilon; 
		
		//sigma ^ 6
		double par_sigma6; 
	};
}
