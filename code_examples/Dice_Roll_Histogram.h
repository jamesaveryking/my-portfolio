#pragma once
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <string>
#include <chrono>
#include <thread>

using namespace std;
typedef unsigned int uint;


class histogram
{
public:
	histogram();
	void computeDiceRollMatrix(uint repetitions);
	uint rollDie();
	void conclusionMessage();
	void outOfRangeMessage();
	~histogram();
};

