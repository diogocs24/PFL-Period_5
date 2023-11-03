:- dynamic last_move/2.
:- use_module(library(random)).


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

get_move([Board,Player], Col1-Row1-Col2-Row2) :-
    repeat,
    get_name(Player, Name),
    write('Player '), write(Name), write(', please enter your move: '), nl,
    write('Origin Row: '), read_number(Row1),
    write('Origin Column: '), read_number(Col1),
    write('Destination Row: '), read_number(Row2),
    write('Destination Column: '), read_number(Col2),
    (valid_move([Board,Player], Col1-Row1, Col2-Row2) ->
        !
    ; 
        write('Invalid move. Please try again.'), nl, fail
    ).

valid_move([Board,Player], Col1-Row1, Col2-Row2) :-
    inside_board(Board, Col1-Row1),
    inside_board(Board, Col2-Row2),
    valid_origin([Board,Player], Col1-Row1), valid_destination(Board, Col1-Row1, Col2-Row2),
    is_orthogonal(Col1-Row1, Col2-Row2),
    pieces_in_path(Board, Col1-Row1, Col2-Row2).

pieces_in_path(_, Col1-Row1, Col1-Row1).
pieces_in_path(Board, Col1-Row1, Col2-Row2) :-
    next_position(Col1-Row1, Col2-Row2, NextPos), 
    get_pos(Board, NextPos, Piece),
    pick_piece(Piece, empty),
    pieces_in_path(Board, NextPos, Col2-Row2).

next_position(Col1-Row1, Col2-Row2, Col1-NextRow) :- 
    Row1 < Row2,
    NextRow is Row1 + 1.
next_position(Col1-Row1, Col2-Row2, Col1-NextRow) :- 
    Row1 > Row2,
    NextRow is Row1 - 1.
next_position(Col1-Row1, Col2-Row2, NextCol-Row1) :- 
    Col1 < Col2,
    NextCol is Col1 + 1.
next_position(Col1-Row1, Col2-Row2, NextCol-Row1) :- 
    Col1 > Col2,
    NextCol is Col1 - 1.

inside_board(Board, Col-Row) :-
    length(Board, Size),
    between(1, Size, Col),
    between(1, Size, Row).

valid_origin([Board,Player], Col-Row) :-
    get_pos(Board, Col-Row, Piece),
    \+pick_piece(Piece, empty),
    pick_piece(Player, Piece).

valid_destination(Board, Col1-Row1, Col2-Row2) :-
    get_pos(Board, Col2-Row2, Piece),
    pick_piece(Piece, empty).

make_move([Board,Player], Col1-Row1-Col2-Row2, [NewBoard,NewPlayer]) :-
    move_piece(Board, Col1-Row1-Col2-Row2, NewBoard),
    next_player(Player, NewPlayer).

move_piece(Board, Col1-Row1-Col2-Row2, NewBoard) :-
    get_pos(Board, Col1-Row1, Piece),
    set_piece(Board, Col1-Row1, empty, TempBoard),
    set_piece(TempBoard, Col2-Row2, Piece, NewBoard).
