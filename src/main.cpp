#include <iostream>

#include <simple/System.cuh>

int main()
{
	simple::System par(1024 * 16);
	for (int i = 0; i < 10; ++i)
	{
		std::cout << "Computation " << i << " started...\n";
		par.compute();

		std::cout << "Advancing " << i << " started...\n";
		par.advance();

		std::cout << "Finished " << i << "!\n\n";
	}
}