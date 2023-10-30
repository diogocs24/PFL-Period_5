consult('auxiliar.pl').
consult('game.pl').

firstMenu :-
    printFirstMenu,
    menuInput,
    read_number(Input),
    option(Input).

option(1) :-   
    game_init('C','C'),   
    firstMenu.

option(2) :-
    game_init('P','C'),
    firstMenu.

option(3) :-
    write('Enter the name of Player 1: '),
    read_cont(Player1Name, []),
    write('Enter the name of Player 2: '),
    read_cont(Player2Name, []),
    game_init(Player1Name,Player2Name),
    firstMenu.

option(4) :-
    write('\nQuitting...\n\n'),
    abort.


option(_Other) :-
    write('\nInvalid Option. Try again:\n\n'),
    menuInput,
    read_number(Input),
    option(Input).


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
    write('|                               4. Quit                                            |'), nl,
    write('|                                                                                  |'), nl,
    write('|__________________________________________________________________________________|'), nl, nl, nl.



menuInput :-
    write('Choose game mode: ').