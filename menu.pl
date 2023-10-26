firstMenu :-
    printFirstMenu.
    % askMenuOption,
    % read(Input),
    % manageInput(Input).

% manageInput(1) :-
%     startGame('P','P'),
%     firstMenu.

% manageInput(2) :-
%     startGame('P','C'),
%     firstMenu.

% manageInput(3) :-
%     startGame('C','C'),
%     firstMenu.

% manageInput(4) :-
%     write('valid option!\n\n').

% manageInput(0) :-
%     write('\nExiting...\n\n').

% manageInput(_Other) :-
%     write('\nERROR: that option does not exist.\n\n'),
%     askMenuOption,
%     read(Input),
%     manageInput(Input).


printFirstMenu :-
    nl, nl,
    write(' __________________________________________________________________________________ '), nl,
    write('|                                                                                  |'), nl,
    write('|                                                             _                    |'), nl,
    write('|      _ _ _                           _                     |_|       _ _ _ _     |'), nl,
    write('|     |_|_|_|      _ _      _    _ _  |_|      _ _        _ _|_|      |_|_|_|_|    |'), nl,
    write('|    |_|_ _|_|   _|_|_|_   |_|_ |_|_|  _    _ |_|_| _    |_|_|_|      |_|_ _       |'), nl,
    write('|    |_|_|_|    |_|_|_|_|  |_|_|      |_|  |_|     |_|  |_|  |_|      |_|_|_|_     |'), nl,
    write('|    |_|        |_|_ _ _   |_|        |_|  |_| _ _ |_|  |_| _|_|       _ _ _|_|    |'), nl,
    write('|    |_|          |_|_|_|  |_|        |_|     |_|_|      |_|_|_|      |_|_|_|      |'), nl,
    write('|                                                                                  |'), nl,
    write('|                                                                                  |'), nl,
    write('|                                   *************                                  |'), nl,
    write('|                                WELCOME TO PERIOD 5                               |'), nl,
    write('|                                   *************                                  |'), nl,
    write('|                    -----------------------------------------                     |'), nl,
    write('|                                                                                  |'), nl,
    write('|                                                                                  |'), nl,
    write('|                               1. Computer vs Computer                            |'), nl,
    write('|                                                                                  |'), nl,
    write('|                               2. Player vs Computer                              |'), nl,
    write('|                                                                                  |'), nl,
    write('|                               3. Player vs Player                                |'), nl,
    write('|                                                                                  |'), nl,
    write('|                               0. Exit                                            |'), nl,
    write('|                                                                                  |'), nl,
    write('|__________________________________________________________________________________|'), nl.



% askMenuOption :-
%     write('> Insert your option ').