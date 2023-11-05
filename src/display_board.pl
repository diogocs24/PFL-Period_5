:- use_module(library(lists)).

print_board(Board) :-
    length(Board, Size),
    print_h(Size),
    r_draw(Board, 1, Size).

print_h(Size) :-
    h_draw(1, Size),
    b_draw(Size).

pick_piece(Board, Col-Row, Piece) :- 
    nth1(Row, Board, Line),
    nth1(Col, Line, Piece), !.

get_symbol(Board, Line, Col, Symbol):-
    pick_piece(Board,Col-Line,Piece),
    symbol(Piece, Symbol).

p_draw(_, _, Col, Size):- 
    Col > Size, write('\n  '), !.
p_draw(Board, Line, Col, Size):-
    get_symbol(Board, Line, Col, Symbol),
    format(' ~a |', [Symbol]),
    NextCol is Col + 1,
    p_draw(Board, Line, NextCol, Size).

r_draw(_, Line, Size):- 
    Line > Size, nl, !.
r_draw(Board, Line, Size):-
    Line > 9,
    format('~d|', [Line]),
    p_draw(Board, Line, 1, Size),
    b_draw(Size),
    NextLine is Line + 1,
    r_draw(Board, NextLine, Size), !.
r_draw(Board, Line, Size):-
    format('~d |', [Line]),
    p_draw(Board, Line, 1, Size),
    b_draw(Size),
    NextLine is Line + 1,
    r_draw(Board, NextLine, Size).

h_draw(Size, Size) :- 
    format('~d\n  ', [Size]), !.
h_draw(1, Max) :- 
    write('\n    1   '), 
    h_draw(2, Max), !.
h_draw(N, Max) :- 
    N > 9, 
    format('~d  ', [N]), 
    Next is N + 1, 
    h_draw(Next, Max).
h_draw(N, Max) :- 
    format('~d   ', [N]), 
    Next is N + 1, 
    h_draw(Next, Max).

b_draw(0) :- 
    write('|\n'), !.
b_draw(N) :- 
    write('|---'), 
    N1 is N - 1, 
    b_draw(N1).