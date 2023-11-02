:- dynamic last_move/2.

display_game([Board,_]) :-
    print_board(Board).

% game_loop(GameState):-
%     game_over(GameState, Winner), !,
%     display_game(GameState),
%     show_winner(GameState, Winner).
game_loop(GameState):-
    display_game(GameState),
    get_move(GameState, Move),
    make_move(GameState, Move, NewGameState), !,
    game_loop(NewGameState).

get_move([Board,Player], Row1-Col1-Row2-Col2) :-
    repeat,
    name_of(Player, Name),
    write('Player '), write(Name), write(', please enter your move: '), nl,
    write('Origin Row: '), read_number(Row1),
    write('Origin Column: '), read_number(Col1),
    write('Destination Row: '), read_number(Row2),
    write('Destination Column: '), read_number(Col2),
    (valid_move([Board,Player], Row1-Col1, Row2-Col2) ->
        ! % Jogada válida, sai do loop repeat
    ; 
        writeln('Invalid move. Please try again.') % Jogada inválida, exibe mensagem e continua o loop repeat
    ).

valid_move([Board,Player], Row1-Col1, Row2-Col2) :-
    valid_origin([Board,Player], Row1-Col1),
    valid_destination([Board,Player], Row1-Col1, Row2-Col2).

valid_origin([Board,Player], Row-Col) :-
    valid_position(Row-Col),
    get_piece([Board,Player], Row-Col, Piece),
    piece_of_player(Piece, Player).
