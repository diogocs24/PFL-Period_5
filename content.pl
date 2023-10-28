info_piece(player1, 'X').
info_piece(player2, 'O').
info_piece(cube, '+').

symbol(empty,X) :- X=' '.
symbol(player1,X) :- X='X'.
symbol(player2,X) :- X='O'.
symbol(cube,X) :- X='+'.

initial_board([
    [empty,player2,empty,empty,empty],
    [player1,empty,player2,empty,empty],
    [empty,player1,cube,player2,empty],
    [empty,empty,player1,empty,player2],
    [empty,empty,empty,player1,empty]
]).
