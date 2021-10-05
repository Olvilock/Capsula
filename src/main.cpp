#include <iostream>

#include "particle_system.cuh"

int main()
{
	particle_system par(1024 * 64);
	for (int i = 0; i < 10; ++i)
	{
		std::cout << "Computation " << i << " started...\n";
		par.compute();

		std::cout << "Advancing " << i << " started...\n";
		par.advance();

		std::cout << "Finished " << i << "!\n\n";
	}
}