#include <iostream>

#include <simple/System.cuh>

int main()
{
	simple::System sys(1024 * 16);
	for (int i = 0; i < 10; ++i)
	{
		std::cout << "Computation " << i << " started...\n";
		sys.compute();

		std::cout << "Advancing " << i << " started...\n";
		sys.advance();

		std::cout << "Finished " << i << "!\n\n";
	}
}