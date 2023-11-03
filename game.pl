:- dynamic last_move/2.
:- use_module(library(random)).


display_game([Board,_]) :-
    print_board(Board),
    colors_positions(Colors),
    print_board(Colors).

game_win_condition([Board,Player],Player) :-
    pieces_in_all_columns([Board,Player]),
    pieces_in_all_colors([Board,Player]).

pieces_in_all_colors([Board,Player]) :-
    length(Board, Size),
    get_player_pieces_positions([Board,Player], Positions),
    has_piece_in_each_color(Positions, Size).

has_piece_in_each_color(Positions, Size) :-
    colors_positions(Colors),
    findall(Color, (
        member(Col-Row, Positions), % get player all pieces positions
        nth1(Row, Colors, ColorRow), % get color row with player pieces positions row
        nth1(Col, ColorRow, Color) % get color from color row with player pieces positions column
    ), PlayerColors),
    sort(PlayerColors, UniqueColors), % remove duplicates
    length(UniqueColors, NumColors),
    NumColors =:= 5.

pieces_in_all_columns([Board,Player]) :-
    length(Board, Size),
    between(1, Size, Col),
    get_player_pieces_positions([Board,Player], Positions),
    has_piece_in_each_column(Positions, Size).

has_piece_in_each_column(Positions, Size) :-
    findall(Col, (member(Col-_, Positions)), Columns),
    sort(Columns, SortedColumns),
    length(SortedColumns, N),
    N =:= Size.
    
game_loop(GameState):-
    display_game(GameState),
    get_move(GameState, Move),
    make_move(GameState, Move, [Board,Player]), !,
    next_player(Player, NextPlayer),
    (game_win_condition([Board, Player], Winner) ->
        display_game([Board, Player]),
        winner_message(Winner)
    ;
        game_loop([Board, NextPlayer])
    ).

get_move([Board,Player], Col1-Row1-Col2-Row2) :-
    repeat,
    get_name(Player, Name),
    write(Name), write(', please enter your move: '), nl,
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
    pieces_in_path(Board, Col1-Row1, Col2-Row2),
    pick_piece(Board, Col1-Row1, Piece),
    (compare_piece(cube, Piece) ->
        is_cube_move_valid(Col1-Row1, Col2-Row2)
    ;
        true
    ).

is_cube_move_valid(Col1-Row1, Col2-Row2) :-
    cube_position(Col,Row),
    (Col-Row =\= Col2-Row2 -> 
        true;
        fail
    ).

pieces_in_path(_, Col1-Row1, Col1-Row1).
pieces_in_path(Board, Col1-Row1, Col2-Row2) :-
    next_position(Col1-Row1, Col2-Row2, NextPos), 
    pick_piece(Board, NextPos, Piece),
    compare_piece(Piece, empty),
    pieces_in_path(Board, NextPos, Col2-Row2).

next_position(Col1-Row1, _-Row2, Col1-NextRow) :- 
    Row1 < Row2,
    NextRow is Row1 + 1.
next_position(Col1-Row1, _-Row2, Col1-NextRow) :- 
    Row1 > Row2,
    NextRow is Row1 - 1.
next_position(Col1-Row1, Col2-_, NextCol-Row1) :- 
    Col1 < Col2,
    NextCol is Col1 + 1.
next_position(Col1-Row1, Col2-_, NextCol-Row1) :- 
    Col1 > Col2,
    NextCol is Col1 - 1.

inside_board(Board, Col-Row) :-
    length(Board, Size),
    between(1, Size, Col),
    between(1, Size, Row).

valid_origin([Board,Player], Col-Row) :-
    pick_piece(Board, Col-Row, Piece),
    \+compare_piece(empty, Piece),
    (compare_piece(Player, Piece) ; compare_piece(cube,Piece)).

valid_destination(Board, Col1-Row1, Col2-Row2) :-
    pick_piece(Board, Col2-Row2, Piece),
    compare_piece(Piece, empty).

make_move([Board,Player], Col1-Row1-Col2-Row2, [NewBoard,Player]) :-
    move_piece(Board, Col1-Row1-Col2-Row2, NewBoard).

move_piece(Board, Col1-Row1-Col2-Row2, NewBoard) :-
    pick_piece(Board, Col1-Row1, Piece),
    (compare_piece(cube, Piece) ->
        cube_position(Col,Row),
        retract(cube_position(Col,Row)),
        asserta(cube_position(Col1,Row1))
    ;
        true
    ),
    set_piece(Board, Col1-Row1, empty, TempBoard),
    set_piece(TempBoard, Col2-Row2, Piece, NewBoard).
