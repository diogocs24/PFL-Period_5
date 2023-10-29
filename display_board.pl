:- use_module(library(lists)).
% display_board.pl
:- consult('content.pl').


% Predicado para imprimir o tabuleiro
print_board :-
    initial_board(Board),
    length(Board, Size), % Obtém o tamanho do tabuleiro
    print_header(Size),
    display_rows(Board, 1, Size).

% Predicado para imprimir o cabeçalho com números de coluna
print_header(Size) :-
    display_header(1, Size),
    display_bar(Size).

position(Board, Col-Row, Piece) :- 
    nth1(Row, Board, Line),
    nth1(Col, Line, Piece), !.

get_symbol(Board, Line, Col, Symbol):-
    position(Board,Col-Line,Piece),
    symbol(Piece, Symbol).

display_pieces(_, _, Col, Size):- 
    Col > Size, write('\n  '), !.
display_pieces(Board, Line, Col, Size):-
    get_symbol(Board, Line, Col, Symbol),
    format(' ~a |', [Symbol]),
    NextCol is Col + 1,
    display_pieces(Board, Line, NextCol, Size).

display_rows(_, Line, Size):- 
    Line > Size, nl, !.
display_rows(Board, Line, Size):-
    Line > 9,
    format('~d|', [Line]),
    display_pieces(Board, Line, 1, Size),
    display_bar(Size),
    NextLine is Line + 1,
    display_rows(Board, NextLine, Size), !.
display_rows(Board, Line, Size):-
    format('~d |', [Line]),
    display_pieces(Board, Line, 1, Size),
    display_bar(Size),
    NextLine is Line + 1,
    display_rows(Board, NextLine, Size).

% Predicado para imprimir o cabeçalho com números de coluna
display_header(Size, Size) :- 
    format('~d\n  ', [Size]), !.
display_header(1, Max) :- 
    write('\n    1   '), 
    display_header(2, Max), !.
display_header(N, Max) :- 
    N > 9, 
    format('~d  ', [N]), 
    Next is N + 1, 
    display_header(Next, Max).
display_header(N, Max) :- 
    format('~d   ', [N]), 
    Next is N + 1, 
    display_header(Next, Max).

% Predicado para imprimir uma barra horizontal
display_bar(0) :- 
    write('|\n'), !.
display_bar(N) :- 
    write('|---'), 
    N1 is N - 1, 
    display_bar(N1).

