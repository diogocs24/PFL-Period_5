consult('auxiliar.pl').
consult('game.pl').

firstMenu([Board, Player]) :-
    printFirstMenu,
    menuInput,
    read_number(Input),
    option(Input),
    Player = playerX,
    initial_board(Board).

option(1) :-   
    display_game('C','C').   

option(2) :-
    display_game('P','C').

option(3) :-
    write('Enter the name of Player X (starts playing): '),
    player_name(playerX),
    write('Enter the name of Player O: '),
    player_name(playerO).

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