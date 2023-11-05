:- use_module(library(random)).


display_game([Board,_]) :-
    length(Board, Size),
    print_board(Board),
    colors_positions(Size, Colors),
    print_board(Colors).

game_over([Board,Player],Player) :-
    pieces_in_all_columns([Board,Player]),
    pieces_in_all_colors([Board,Player]).

pieces_in_all_colors([Board,Player]) :-
    length(Board, Size),
    get_player_pieces_positions([Board,Player], Positions),
    has_piece_in_each_color(Positions, Size).

has_piece_in_each_color(Positions, Size) :-
    colors_positions(Size, Colors),
    findall(Color, (
        member(Col-Row, Positions), % get player all pieces positions
        nth1(Row, Colors, ColorRow), % get color row with player pieces positions row
        nth1(Col, ColorRow, Color) % get color from color row with player pieces positions column
    ), PlayerColors),
    sort(PlayerColors, UniqueColors), % remove duplicates
    length(UniqueColors, NumColors),
    NumColors =:= Size.

pieces_in_all_columns([Board,Player]) :-
    length(Board, Size),
    get_player_pieces_positions([Board,Player], Positions),
    has_piece_in_each_column(Positions, Size).

has_piece_in_each_column(Positions, Size) :-
    findall(Col, (member(Col-_, Positions)), Columns),
    sort(Columns, SortedColumns),
    length(SortedColumns, N),
    N =:= Size.

has_piece_in_each_color_aux(Positions, Size) :-
    colors_positions(Size, Colors),
    findall(Color, (
        member(Col-Row, Positions), % get player all pieces positions
        nth1(Row, Colors, ColorRow), % get color row with player pieces positions row
        nth1(Col, ColorRow, Color) % get color from color row with player pieces positions column
    ), PlayerColors),
    sort(PlayerColors, UniqueColors), % remove duplicates
    length(UniqueColors, NumColors),
    NumColors =:= Size - 1.

has_piece_in_each_column_aux(Positions, Size) :-
    findall(Col, (member(Col-_, Positions)), Columns),
    sort(Columns, SortedColumns),
    length(SortedColumns, N),
    N =:= Size - 1.

game_loop(GameState):-
    display_game(GameState),
    (check_is_bot(GameState, Diff) ->
        bot_move(GameState, Move, Diff);
        get_move(GameState, Move)
    ),
    make_move(GameState, Move, [Board,Player]), !,
    next_player(Player, NextPlayer),
    (game_over([Board, Player], Winner) ->
        display_game([Board, Player]),
        winner_message(Winner)
    ;
        game_loop([Board, NextPlayer])
    ).

check_is_bot([_,Player], Diff) :-
    bot_diff(Player, Diff),
    (compare_diff(Diff,1) ->
        true
        ;
        (compare_diff(Diff,2) ->
            true;
            fail
        )
    ).

valid_moves([Board, Player], Moves) :-
    length(Board, Size),
    get_player_pieces_positions([Board,Player], Positions),
    findall(Col1-Row1-Col2-Row2, (
        member(Col1-Row1, Positions),
        between(1, Size, Col2),
        between(1, Size, Row2),
        valid_move([Board,Player], Col1-Row1, Col2-Row2)
    ), Moves).

pieces_col_num([Board, Player], Col, Count) :-
    get_player_pieces_positions([Board, Player], Positions),
    findall(_, (member(Col-_, Positions), Col =:= Col), CountList),
    length(CountList, Count).

select_column_with_at_least_two_pieces([Board, Player], SelectedCol) :-
    length(Board, Size),
    select_column_with_at_least_two_pieces([Board, Player], 1, Size, SelectedCol).

select_column_with_at_least_two_pieces(_, _, Col, _, _) :- Col =:= 0, !, fail.
select_column_with_at_least_two_pieces([Board, Player], Col, _, SelectedCol) :-
    pieces_col_num([Board, Player], Col, Count),
    Count >= 2,
    SelectedCol is Col.
select_column_with_at_least_two_pieces([Board, Player], Col, Size, SelectedCol) :-
    NextCol is Col + 1,
    select_column_with_at_least_two_pieces([Board, Player], NextCol, Size, SelectedCol).

select_downward_move(Moves, Col1-Row1-Col2-Row2) :-
    findall(Col1-Row1-Col2-Row2, (
        member(Col1-Row1-Col2-Row2, Moves),
        Row2 > Row1
    ), DownwardMoves),
    random_member(Col1-Row1-Col2-Row2, DownwardMoves).

select_upward_move(Moves, Col1-Row1-Col2-Row2) :-
    findall(Col1-Row1-Col2-Row2, (
        member(Col1-Row1-Col2-Row2, Moves),
        Row2 < Row1
    ), DownwardMoves),
    random_member(Col1-Row1-Col2-Row2, DownwardMoves).


% select_empty_column([Board, Player], EmptyCol) :-
%     length(Board, Size),
%     select_empty_column([Board, Player], 1, Size, EmptyCol).

% select_empty_column(_, _, Col, _, _) :- Col =:= 0, !, fail.
% select_empty_column([Board, Player], Col, Size, EmptyCol) :-
%     pieces_col_num([Board, Player], Col, Count),
%     (Count =:= 0 ->
%         EmptyCol is Col
%     ;
%         NextCol is Col + 1,
%         select_empty_column([Board, Player], NextCol, Size, EmptyCol)
%     ).


bot_move([Board, Player], Col1-Row1-Col2-Row2, 1) :-
    get_name(Player, Name),
    write('Bot '),
    write(Name),
    write(' is thinking...'), nl,
    valid_moves([Board, Player], Moves),
    random_member(Col1-Row1-Col2-Row2, Moves),
    write('Bot chose: '), nl,
    write('----FROM----'), nl,
    write('Row: '), write(Row1), nl,
    write('Column: '), write(Col1), nl,
    write('----TO----'), nl,
    write('Row: '), write(Row2), nl,
    write('Column: '), write(Col2), nl.

bot_move([Board, Player], Col1-Row1-Col2-Row2, 2) :-
    get_name(Player, Name),
    write('Bot '),
    write(Name),
    write(' is thinking...'), nl,
    valid_moves([Board, Player], Moves),
    (pieces_in_all_columns([Board, Player])
    ->
        (select_downward_move(Moves, Col1-Row1-Col2-Row2) -> true 
        ;
         select_upward_move(Moves, Col1-Row1-Col2-Row2)
        )
        ;
        select_column_with_at_least_two_pieces([Board, Player], SelectedCol),
        findall(Col1-Row1-Col2-Row2, (
            member(Col1-Row1-Col2-Row2, Moves),
            Col1 =:= SelectedCol
        ), SelectedMoves),
        random_member(Col1-Row1-Col2-Row2, SelectedMoves)
    ),
    write('Bot chose: '), nl,
    write('----FROM----'), nl,
    write('Row: '), write(Row1), nl,
    write('Column: '), write(Col1), nl,
    write('----TO----'), nl,
    write('Row: '), write(Row2), nl,
    write('Column: '), write(Col2), nl.

get_move([Board,Player], Col1-Row1-Col2-Row2) :-
    repeat,
    get_name(Player, Name),
    write(Name), write(', please enter your move: '), nl,
    write('----FROM----'), nl,
    write('Row: '), read_number(Row1),
    write('Column: '), read_number(Col1),
    write('----TO----'), nl,
    write('Row: '), read_number(Row2),
    write('Column: '), read_number(Col2),
    (valid_move([Board,Player], Col1-Row1, Col2-Row2) ->
        !
    ; 
        write('Invalid move. Please try again.'), nl, fail
    ).

valid_move([Board,Player], Col1-Row1, Col2-Row2) :-
    inside_board(Board, Col1-Row1),
    inside_board(Board, Col2-Row2),
    valid_origin([Board,Player], Col1-Row1), valid_destination(Board, Col2-Row2),
    is_orthogonal(Col1-Row1, Col2-Row2),
    pieces_in_path(Board, Col1-Row1, Col2-Row2),
    pick_piece(Board, Col1-Row1, Piece),
    (compare_piece(cube, Piece) ->
        is_cube_move_valid([Board, Player], Col2-Row2)
    ;
        true
    ).

is_cube_move_valid([Board, Player], Col2-Row2) :-
    (is_other_player_gonna_win([Board, Player]) ->
        fail;
        true
    ),
    cube_position(Col,Row),
    ((Col =\= Col2 , Row =\= Row2) ->
        true
    ;
        fail
    ).

is_other_player_gonna_win([Board, Player]) :-
    length(Board, Size),
    next_player(Player, OtherPlayer),
    get_player_pieces_positions_without_cube([Board,OtherPlayer], Positions),
    has_piece_in_each_color_aux(Positions, Size),
    has_piece_in_each_column_aux(Positions, Size).

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

valid_destination(Board, Col2-Row2) :-
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
        cube_position(Col,Row),
        retract(cube_position(Col,Row)),
        asserta(cube_position(-1,-1)),
        true
    ),
    set_piece(Board, Col1-Row1, empty, TempBoard),
    set_piece(TempBoard, Col2-Row2, Piece, NewBoard).
