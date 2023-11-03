:- dynamic get_name/2.

:- dynamic bot_diff/2.

pick_piece(playerX, x).
pick_piece(playerO, o).
pick_piece(cube, plus).
pick_piece(empty, empty).

symbol(empty,X) :- X=' '.
symbol(x,X) :- X='X'.
symbol(o,X) :- X='O'.
symbol(plus,X) :- X='+'.

is_orthogonal(_-Row,_-Row).
is_orthogonal(Col-_,Col-_).

are_equal(X, X).

next_player(playerX, playerO).
next_player(playerO, playerX).

initial_board([
    [empty,o,empty,empty,empty],
    [x,empty,o,empty,empty],
    [empty,x,plus,o,empty],
    [empty,empty,x,empty,o],
    [empty,empty,empty,x,empty]
]).
