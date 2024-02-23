% puzzle2.pl
% Description: Solves the birthday puzzle of the five sisters.
% Usage: Start SWI-Prolog and consult this file. Then, run solve_birthday_puzzle.

solve_birthday_puzzle(Solution) :-
    Solution = [sister(abigail, _, _), sister(brenda, _, _), sister(mary, _, _), sister(paula, _, _), sister(tara, _, _)],
    % Encoding of the months and days as per the puzzle
    Months = [february, march, july, june, december],
    Days = [monday, wednesday, friday, saturday, sunday],
    % Assigning each sister a month and a day, ensuring all are unique
    assign_month_day(Solution, Months, Days),
    % Clue 1: Paula was born in March but not on Saturday.
    member(sister(paula, march, Day), Solution), Day \= saturday,
    % Clue 2: Abigail's birthday was not on Friday or Wednesday.
    member(sister(abigail, _, ADay), Solution), ADay \= friday, ADay \= wednesday,
    % Clue 3: The girl whose birthday is on Monday was born earlier in the year than Brenda and Mary.
    member(sister(_, MonthBeforeBrendaAndMary, monday), Solution),
    (member(sister(brenda, MonthBrenda, _), Solution), Months.index(MonthBeforeBrendaAndMary) < Months.index(MonthBrenda)),
    (member(sister(mary, MonthMary, _), Solution), Months.index(MonthBeforeBrendaAndMary) < Months.index(MonthMary)),
    % Clue 4: Tara wasn't born in February and her birthday was on the weekend.
    member(sister(tara, TaraMonth, TaraDay), Solution), TaraMonth \= february, (TaraDay = saturday; TaraDay = sunday),
    % Clue 5: Mary was not born in December nor on a weekday, her birthday is on Sunday in June.
    member(sister(mary, june, sunday), Solution),
    % Tara was born before Brenda
    (member(sister(brenda, BrendaMonth, _), Solution), member(sister(tara, TaraMonthBefore, _), Solution), Months.index(TaraMonthBefore) < Months.index(BrendaMonth)),
    % Brenda's birthday wasn't on Friday, Mary wasn't born in July.
    member(sister(brenda, _, BD), Solution), BD \= friday,
    member(sister(mary, MaryMonth, _), Solution), MaryMonth \= july.

% Helper predicate to assign each sister a unique month and day
assign_month_day([], [], []).
assign_month_day([sister(_, Month, Day) | Sisters], Months, Days) :-
    select(Month, Months, RemainingMonths),
    select(Day, Days, RemainingDays),
    assign_month_day(Sisters, RemainingMonths, RemainingDays).

% Helper to find index of an element in a list
list_index(El, [El|_], 0):- !.
list_index(El, [_|T], Index):-
  list_index(El, T, Index1),
  !,
  Index is Index1+1.
