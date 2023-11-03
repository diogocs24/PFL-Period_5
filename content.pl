:- dynamic get_name/2.

:- dynamic bot_diff/2.

:- dynamic cube_position/2.

compare_piece(playerX, x).
compare_piece(playerO, o).
compare_piece(cube, plus).
compare_piece(empty, empty).

symbol(empty,X) :- X=' '.
symbol(x,X) :- X='X'.
symbol(o,X) :- X='O'.
symbol(plus,X) :- X='+'.

symbol(white,X) :- X='W'.
symbol(black,X) :- X='B'.
symbol(red,X) :- X='R'.
symbol(green,X) :- X='G'.
symbol(purple,X) :- X='P'.

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

colors_positions([
    [red, white, purple, black, green],
    [green,red, white, purple, black],
    [black, green, red, white, purple],
    [purple, black, green, red, white],
    [white, purple, black, green, red]
]).

