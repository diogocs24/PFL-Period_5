:- use_module(library(between)).

% input without using dot (professors code)
read_number(X):-
    read_number_aux(X,0).
read_number_aux(X,Acc):- 
    get_code(C),
    between(48, 57, C), !,
    Acc1 is 10*Acc + (C - 48),
    read_number_aux(X,Acc1).
read_number_aux(X,X).

read_cont(X, Acc):-
    get_char(Input),
    Input \= '\n',
    append(Acc, [Input], Acc1),
    read_cont(X, Acc1).
read_cont(X, Acc):-
    atom_chars(X, Acc).

player_name(Player):-
    read_cont(Name, []),
    asserta(get_name(Player, Name)).

set_piece(Board, Col-Row, Piece, NewBoard) :-
    set_element(Board, Row, Col, Piece, NewBoard).

set_element([], _, _, _, []).
set_element([Row|Rest], 1, Col, Piece, [NewRow|Rest]) :-
    set_column(Row, Col, Piece, NewRow).
set_element([Row|Rest], RowIndex, Col, Piece, [Row|NewRest]) :-
    RowIndex > 1,
    NextRowIndex is RowIndex - 1,
    set_element(Rest, NextRowIndex, Col, Piece, NewRest).

set_column([], _, _, []).
set_column([_|Rest], 1, Piece, [Piece|Rest]).
set_column([X|Rest], Col, Piece, [X|NewRest]) :-
    Col > 1,
    NextCol is Col - 1,
    set_column(Rest, NextCol, Piece, NewRest).

initialize_cube_position(N) :-
    Pos is N div 2 + 1,
    assert(cube_position(Pos,Pos)). 

get_player_pieces_positions([Board, Player], Positions) :-
    length(Board, N),
    findall(Col-Row, (between(1, N, Row), between(1, N, Col), (pick_piece(Board, Col-Row, Piece), (compare_piece(Player,Piece) ; compare_piece(cube,Piece)))), Positions).

get_player_pieces_positions_without_cube([Board, Player], Positions) :-
    length(Board, N),
    findall(Col-Row, (between(1, N, Row), between(1, N, Col), (pick_piece(Board, Col-Row, Piece), compare_piece(Player,Piece))), Positions).

winner_message(Player) :-
    get_name(Player, Name),
    write('****************************************'), nl,
    write('Congratulations '), write(Name), write('! You won!'), nl,
    write('****************************************'), nl.

draw_bot_thinking(Player) :-
    get_name(Player, Name),
    write('Bot '), write(Name), write(' is thinking...'), nl.

draw_bot_move(Player, Col1-Row1-Col2-Row2) :-
    get_name(Player, Name),
    write('Bot '),
    write(Name),
    write(' chose: '), nl,
    write('----FROM----'), nl,
    write('Row: '), write(Row1), nl,
    write('Column: '), write(Col1), nl,
    write('----TO----'), nl,
    write('Row: '), write(Row2), nl,
    write('Column: '), write(Col2), nl.