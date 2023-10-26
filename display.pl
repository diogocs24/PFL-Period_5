initial_board([
[empty,o,empty,empty,empty],
[x,empty,o,empty,empty],
[empty,x,cube,o,empty],
[empty,empty,x,empty,o],
[empty,empty,empty,x,empty]
]).

info_piece(player1, 'X').
info_piece(player2, 'O').
info_piece(cube, '+').

symbol(empty,X) :- X=' '.
symbol(player1,X) :- X='X'.
symbol(player2,X) :- X='O'.
symbol(cube,X) :- X='+'.


printBoard(X) :-
    nl,
    write('   | 1 | 2 | 3 | 4 | 5 |\n'),
    write('---|---|---|---|---|---|\n'),
    printMatrix(X, 1).

printMatrix([], 6).

printMatrix([Head|Tail], N) :-
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
