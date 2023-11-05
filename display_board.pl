:- use_module(library(lists)).


print_board(Board) :-
    length(Board, Size), 
    print_board_header(Size),
    display_board_rows(Board, 1, Size).


print_board_header(Size) :-
    display_board_header(1, Size),
    display_horizontal_bar(Size).

pick_piece(Board, Col-Row, Piece) :- 
    nth1(Row, Board, Line),
    nth1(Col, Line, Piece), !.

get_symbol(Board, Line, Col, Symbol):-
    pick_piece(Board,Col-Line,Piece),
    symbol(Piece, Symbol).

display_pieces(_, _, Col, Size):- 
    Col > Size, write('\n  '), !.
display_pieces(Board, Line, Col, Size):-
    get_symbol(Board, Line, Col, Symbol),
    format(' ~a |', [Symbol]),
    NCol is Col + 1,
    display_pieces(Board, Line, NCol, Size).

display_board_rows(_, Line, Size):- 
    Line > Size, nl, !.
display_board_rows(Board, Line, Size):-
    Line > 9,
    format('~d|', [Line]),
    display_pieces(Board, Line, 1, Size),
    display_bar(Size),
    NLine is Line + 1,
    display_rows(Board, NLine, Size), !.
display_board_rows(Board, Line, Size):-
    format('~d |', [Line]),
    display_pieces(Board, Line, 1, Size),
    display_bar(Size),
    NLine is Line + 1,
    display_rows(Board, NLine, Size).


display_board_header(Size, Size) :- 
    format('~d\n  ', [Size]), !.
display_board_header(1, Max) :- 
    write('\n    1   '), 
    display_header(2, Max), !.
display_board_header(X, Max) :- 
    X > 9, 
    format('~d  ', [X]), 
    X is X + 1, 
    display_header(X, Max).
display_board_header(X, Max) :- 
    format('~d   ', [X]), 
    X is X + 1, 
    display_header(X, Max).

display_horizontal_bar(0) :-
    write('|\n').
display_horizontal_bar(X) :-
    write('|---'),
    X1 is X - 1,
    display_horizontal_bar(X1).

