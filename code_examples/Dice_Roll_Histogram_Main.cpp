#include "main.h"
#include "histogram.h"


using namespace std;
using namespace std::this_thread;
using namespace std::chrono;

main::main()
{
}

void main()
{
	histogram hist;
	int number_of_repetitions = 1;
	while (number_of_repetitions != 0)
	{
		cout << "Please enter the number of repetitions you wish for me to perform: [0 to quit]" << endl;
		cin >> number_of_repetitions;
		
		if (number_of_repetitions == 0)
		{
			hist.conclusionMessage();
			sleep_for(seconds(2));
			return;
		}
		else if (number_of_repetitions > 430 || number_of_repetitions < 200)
		{
			while(number_of_repetitions > 430 || number_of_repetitions < 200)
			{
				if (number_of_repetitions == 0)
				{
					hist.conclusionMessage();
					sleep_for(seconds(2));
					return;
				}
				hist.outOfRangeMessage();
				cin >> number_of_repetitions;
			}
		}
		else
		{
			hist.computeDiceRollMatrix(number_of_repetitions);
		}
	}
}


main::~main()
{
}
