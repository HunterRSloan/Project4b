% guess.pl
% Description: A simple number guessing game.
% The program picks a random number between 1 and 20, and the user has to guess it.
% Usage: Start SWI-Prolog and consult this file. Then, run start_guessing_game.

:- use_module(library(random)).
:- use_module(library(system)).

% Entry point for the game.
start_guessing_game :-
    random(1, 21, Secret),
    format('I have chosen a number between 1 and 20. Try to guess it!~n', []),
    guess_number(Secret, 0).

% Main game loop. Takes the secret number and the count of guesses so far.
guess_number(Secret, Count) :-
    format('Enter your guess: ', []),
    read(Guess),
    (   Guess == Secret ->
        SuccCount is Count + 1,
        format('Congratulations! You have guessed the number correctly in ~d attempts.~n', [SuccCount])
    ;   Guess < Secret ->
        format('Too low. Try again.~n', []),
        SuccCount is Count + 1,
        guess_number(Secret, SuccCount)
    ;   Guess > Secret ->
        format('Too high. Try again.~n', []),
        SuccCount is Count + 1,
        guess_number(Secret, SuccCount)
    ).
