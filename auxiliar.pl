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

read_cont(Result, Acc):-
    get_char(Char),
    Char \= '\n',
    append(Acc, [Char], Acc1),
    read_cont(Result, Acc1).
read_cont(Result, Acc):-
    atom_chars(Result, Acc).

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

initialize_cube_position :-
    assert(cube_position(3,3)). 


