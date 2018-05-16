
import math

guesses = 1
minimum = 0
maximum = 0
guess = 0


def searchTheGivenRange(minimum, maximum, guesses, guess):
	previousGuess = guess
	guess = math.floor(((maximum - minimum) / 2) + minimum)
	if previousGuess == guess:
		print("The game is over, I just guessed your number")
		return
	print("Is it " + str(guess) + "?")
	answer = input("Tell me too high with >, too low with <, or y if I got it!\n")
	if answer == "<":
		minimum = guess
		guesses = guesses + 1
		searchTheGivenRange(minimum, maximum, guesses, guess)
	elif answer == ">":
		maximum = guess
		guesses = guesses + 1
		searchTheGivenRange(minimum, maximum, guesses, guess)
	elif answer == "y":
		print("That only took " + str(guesses) + " guesse(s)!")
		return


def main():
	maximum = int(input("What is the maximum range? (1 to __)\n"))
	searchTheGivenRange(minimum, maximum, guesses, guess)

