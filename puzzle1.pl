% puzzle1.pl
% Description: Solves the Grantville Library writing contest puzzle.
% Usage: Start SWI-Prolog and consult this file. Then, run solve_puzzle.

solve_puzzle :-
    Contestants = [_, _, _, _],
    % Each contestant is a term contestant(Name, Animal, Adventure)
    % Clues:
    member(contestant(_, seal, _), Contestants),
    member(contestant(_, _, rock_band), Contestants),
    member(contestant(joanne, _, circus), Contestants),
    member(contestant(winnie, zebra, _), Contestants),
    \+ member(contestant(_, grizzly_bear, spaceship), Contestants),
    \+ member(contestant(joanne, grizzly_bear, _), Contestants),
    \+ member(contestant(lou, seal, _), Contestants),
    \+ member(contestant(_, seal, spaceship), Contestants),
    \+ member(contestant(_, seal, magic_train), Contestants),
    
    % Solution query
    Contestants = [contestant(ralph, _, _)|_],
    member(contestant(_, moose, _), Contestants),
    
    writeln(Contestants).

