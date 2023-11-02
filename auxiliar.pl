:- use_module(library(between)).

% input without using dot (professor's code)
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
    asserta(name_of(Player, Name)).

set_piece_aux([_H|T], 0, Piece, [Piece|T]).
set_piece_aux([H|T], Index, Piece, [H|TNew]) :-
    Index > 0,
    IndexTemp is Index - 1,
    set_piece_aux(T, IndexTemp, Piece, TNew).

set_piece([H|T], Col-0, Piece, [HNew|T]) :-
    set_piece_aux(H, Col, Piece, HNew).

set_piece([H|T], Col-Row, Piece, [H|TNew]) :-
    Row > 0,
    RowTemp is Row - 1,
    set_piece(T, Col-RowTemp, Piece, TNew).

