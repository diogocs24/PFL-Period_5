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

get_move([Board,Player], Col1-Row1-Col2-Row2) :-
    repeat,
    name_of(Player, Name),
    write('Player '), write(Name), write(', please enter your move: '), nl,
    write('Origin Row: '), read_number(Row1),
    write('Origin Column: '), read_number(Col1),
    write('Destination Row: '), read_number(Row2),
    write('Destination Column: '), read_number(Col2),
    (valid_move([Board,Player], Col1-Row1, Col2-Row2) ->
        ! % Jogada válida, sai do loop repeat
    ; 
        write('Invalid move. Please try again.') % Jogada inválida, exibe mensagem e continua o loop repeat
    ).

valid_move([Board,Player], Col1-Row1, Col2-Row2) :-
    inside_board(Board, Col1-Row1),
    inside_board(Board, Col2-Row2),
    valid_origin([Board,Player], Col1-Row1), valid_destination(Board, Col1-Row1, Col2-Row2),
    is_orthogonal(Col1-Row1, Col2-Row2).

pieces_in_path(_, _, _). 
pieces_in_path(Board, Col1-Row1, Col2-Row2) :-
    are_equal(Col1, Col2), 
    Row1 < Row2, 
    Row1Next is Row1 + 1,
    position(Board, Col1-Row1Next, Piece),
    info_piece(Piece, empty),
    pieces_in_path(Board, Col1-Row1Next, Col2-Row2).

pieces_in_path(Board, Col1-Row1, Col2-Row2) :-
    are_equal(Col1, Col2),
    Row1 > Row2, 
    Row1Next is Row1 - 1,
    position(Board, Col1-Row1Next, Piece),
    info_piece(Piece, empty),
    pieces_in_path(Board, Col1-Row1Next, Col2-Row2).

pieces_in_path(Board, Col1-Row1, Col2-Row2) :-
    are_equal(Row1, Row2),
    Col1 < Col2, 
    Col1Next is Col1 + 1,
    position(Board, Col1Next-Row1, Piece),
    info_piece(Piece, empty),
    pieces_in_path(Board, Col1Next-Row1, Col2-Row2).

pieces_in_path(Board, Col1-Row1, Col2-Row2) :-
    are_equal(Row1, Row2),
    Col1 > Col2, 
    Col1Next is Col1 - 1,
    position(Board, Col1Next-Row1, Piece),
    info_piece(Piece, empty),
    pieces_in_path(Board, Col1Next-Row1, Col2-Row2).

inside_board(Board, Col-Row) :-
    length(Board, Size),
    between(1, Size, Col),
    between(1, Size, Row).

valid_origin([Board,Player], Col-Row) :-
    position(Board, Col-Row, Piece),
    \+info_piece(Piece, empty),
    info_piece(Player, Piece).

valid_destination(Board, Col1-Row1, Col2-Row2) :-
    position(Board, Col2-Row2, Piece),
    info_piece(Piece, empty).

make_move([Board,Player], Col1-Row1-Col2-Row2, [NewBoard,NewPlayer]) :-
    move_piece(Board, Col1-Row1-Col2-Row2, NewBoard),
    next_player(Player, NewPlayer).

move_piece(Board, Col1-Row1-Col2-Row2, NewBoard) :-
    position(Board, Col1-Row1, Piece),
    set_piece(Board, Col1-Row1, empty, TempBoard),
    set_piece(TempBoard, Col2-Row2, Piece, NewBoard).
