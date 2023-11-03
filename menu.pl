firstMenu([Board, playerX]) :-
    printFirstMenu,
    menuInput,
    read_number(Input),
    option(Input),
    initialize_cube_position,
    initial_board(Board).

difficulty(Bot) :-
    get_name(Bot, Name),
    write('Choose difficulty for '), write(Name), write(': '), nl,
    write('1. Random'), nl,
    write('2. Greedy'), nl,
    read_number(Input),
    (
        option_difficulty(Input, Bot) -> !;
        write('\nInvalid Option. Try again:\n\n'),
        difficulty(Bot)
    ).

option_difficulty(1, Bot) :-
    write('Random'), nl,
    asserta(bot_diff(Bot, random)).

option_difficulty(2, Bot) :-
    write('Greedy'), nl,
    asserta(bot_diff(Bot, greedy)).

option(1) :-   
    write('Enter the name of Bot X (starts playing): '),
    player_name(playerX),
    write('Enter the name of Bot O: '),
    player_name(playerO),
    difficulty(playerX),
    difficulty(playerO).

option(2) :-
    write('Enter the name of Player X (starts playing): '),
    player_name(playerX),
    write('Enter the name of Bot O: '),
    player_name(playerO),
    difficulty(playerO).

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