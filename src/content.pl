:- dynamic get_name/2.

:- dynamic bot_diff/2.

:- dynamic cube_position/2.

compare_piece(playerX, x).
compare_piece(playerO, o).
compare_piece(cube, plus).
compare_piece(empty, empty).

compare_diff(1,1).
compare_diff(2,2).

symbol(empty,X) :- X=' '.
symbol(x,X) :- X='X'.
symbol(o,X) :- X='O'.
symbol(plus,X) :- X='+'.

symbol(white,X) :- X='W'.
symbol(black,X) :- X='B'.
symbol(red,X) :- X='R'.
symbol(green,X) :- X='G'.
symbol(purple,X) :- X='P'.
symbol(yellow,X) :- X='Y'.
symbol(cyan,X) :- X='C'.
symbol(violet,X) :- X='V'.
symbol(orange,X) :- X='O'.

is_orthogonal(_-Row,_-Row).
is_orthogonal(Col-_,Col-_).

are_equal(X, X).

next_player(playerX, playerO).
next_player(playerO, playerX).

init_state(5, [[
    [empty,o,empty,empty,empty],
    [x,empty,o,empty,empty],
    [empty,x,plus,o,empty],
    [empty,empty,x,empty,o],
    [empty,empty,empty,x,empty]
],playerX]).

init_state(7, [[
    [empty,o,empty,empty,empty,empty,empty],
    [x,empty,o,empty,empty,empty,empty],
    [empty,x,empty,o,empty,empty,empty],
    [empty,empty,x,plus,o,empty,empty],
    [empty,empty,empty,x,empty,o,empty],
    [empty,empty,empty,empty,x,empty,o],
    [empty,empty,empty,empty,empty,x,empty]
],playerX]).

init_state(9, [[
    [empty,o,empty,empty,empty,empty,empty,empty,empty],
    [x,empty,o,empty,empty,empty,empty,empty,empty],
    [empty,x,empty,o,empty,empty,empty,empty,empty],
    [empty,empty,x,empty,o,empty,empty,empty,empty],
    [empty,empty,empty,x,plus,o,empty,empty,empty],
    [empty,empty,empty,empty,x,empty,o,empty,empty],
    [empty,empty,empty,empty,empty,x,empty,o,empty],
    [empty,empty,empty,empty,empty,empty,x,empty,o],
    [empty,empty,empty,empty,empty,empty,empty,x,empty]
],playerX]).

colors_positions(5, [
    [red, white, purple, black, green],
    [green,red, white, purple, black],
    [black, green, red, white, purple],
    [purple, black, green, red, white],
    [white, purple, black, green, red]
]).

colors_positions(7, [
    [red, yellow, violet, orange, cyan, white, purple],
    [purple, red, yellow, violet, orange, cyan, white],
    [white, purple, red, yellow, violet, orange, cyan],
    [cyan, white, purple, red, yellow, violet, orange],
    [orange, cyan, white, purple, red, yellow, violet],
    [violet, orange, cyan, white, purple, red, yellow],
    [yellow, violet, orange, cyan, white, purple, red]
]).

colors_positions(9, [
    [red, yellow, violet, orange, cyan, white, purple, black, green],
    [green,red, yellow, violet, orange, cyan, white, purple, black],
    [black, green, red, yellow, violet, orange, cyan, white, purple],
    [purple, black, green, red, yellow, violet, orange, cyan, white],
    [white, purple, black, green, red, yellow, violet, orange, cyan],
    [cyan, white, purple, black, green, red, yellow, violet, orange],
    [orange,cyan, white, purple, black, green,red, yellow, violet],
    [violet, orange, cyan, white, purple, black, green, red, yellow],
    [yellow, violet, orange, cyan, white, purple, black, green, red]
]).
