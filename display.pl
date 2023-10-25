initialBoard([
[empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty]
]).

symbol(empty,S) :- S=' '.
symbol(black,S) :- S='X'.
symbol(white,S) :- S='O'.
symbol(red,S) :- S='*'.

letter(1, L) :- L='A'.
letter(2, L) :- L='B'.
letter(3, L) :- L='C'.
letter(4, L) :- L='D'.
letter(5, L) :- L='E'.


printBoard(X) :-
    nl,
    write('   | 1 | 2 | 3 | 4 | 5 |\n'),
    write('---|---|---|---|---|---|\n'),
    printMatrix(X, 1).

printMatrix([], 6).

printMatrix([Head|Tail], N) :-
    letter(N, L),
    write(' '),
    write(L),
    N1 is N + 1,
    write(' | '),
    printLine(Head),
    write('\n---|---|---|---|---|---|\n'),
    printMatrix(Tail, N1).

printLine([]).

printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    write(' | '),
    printLine(Tail).
