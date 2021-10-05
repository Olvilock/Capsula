#pragma once

#include <quantities.cuh>

struct constant_type
{
	time_type time_step;
	double epsilon12; //12 * epsilon
	double sigma3; //sigma ^ 3
};
