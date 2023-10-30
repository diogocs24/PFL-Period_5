info_piece(playerX, 'X').
info_piece(playerO, 'O').
info_piece(cube, '+').

symbol(empty,X) :- X=' '.
symbol(playerX,X) :- X='X'.
symbol(playerO,X) :- X='O'.
symbol(cube,X) :- X='+'.

initial_board([
    [empty,playerO,empty,empty,empty],
    [playerX,empty,playerO,empty,empty],
    [empty,playerX,cube,playerO,empty],
    [empty,empty,playerX,empty,playerO],
    [empty,empty,empty,playerX,empty]
]).
