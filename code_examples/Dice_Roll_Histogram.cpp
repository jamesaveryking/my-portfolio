#include "histogram.h"


using namespace std;


histogram::histogram()
{
}

void histogram::computeDiceRollMatrix(uint repetitions)
{
	
	uint frequencies[13] = {0,0,0,0,0,0,0,0,0,0,0,0,0};

	for (uint j = 0; j <= repetitions; j++)
	{
		uint dice_roll = rollDie();

		frequencies[dice_roll]++;
	}

	for (uint i = 2; i <= 12; i++)
	{
		cout << setw(2);
		cout << i << " | ";
		for (uint k = 0; k < frequencies[i]; k++)
		{
			cout << "*";
		}
		cout << endl;
	}
}

uint histogram::rollDie()
{
	uint roll_value1 = rand() % 6 + 1;
	uint roll_value2 = rand() % 6 + 1;
	uint roll_value = roll_value1 + roll_value2;
	return roll_value;
}

void histogram::outOfRangeMessage()
{
	cout << "The number that was entered was out of the optimal range. Please enter a number between 200 and 430: [0 to quit]" << endl;
}

void histogram::conclusionMessage()
{
	cout << "Have a nice day!" << endl;
}


histogram::~histogram()
{
}
