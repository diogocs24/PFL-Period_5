% get_name(+Player, -Name)
% Get the name of a player.
:- dynamic get_name/2.

% bot_diff(+Bot, -Difficulty)
% Get the difficulty of a bot.
:- dynamic bot_diff/2.

% cube_position(+Position, -Cube)
% Get the cube last position.
:- dynamic cube_position/2.

% compare_piece(?Piece, +Symbol)
% Define predicates to compare different pieces and their symbols.
compare_piece(playerX, x).
compare_piece(playerO, o).
compare_piece(cube, plus).
compare_piece(empty, empty).

% compare_diff(+Diff, -Number)
% Define predicates for comparing differences.
compare_diff(1,1).
compare_diff(2,2).

% symbol(+Piece, -Symbol)
% Define predicates to map piece symbols to characters.
symbol(empty,X) :- X=' '.
symbol(x,X) :- X='X'.
symbol(o,X) :- X='O'.
symbol(plus,X) :- X='+'.

% symbol(+Color, -Symbol)
% Define predicates to map piece colors to characters.
symbol(white,X) :- X='W'.
symbol(black,X) :- X='B'.
symbol(red,X) :- X='R'.
symbol(green,X) :- X='G'.
symbol(purple,X) :- X='P'.
symbol(yellow,X) :- X='Y'.
symbol(cyan,X) :- X='C'.
symbol(violet,X) :- X='V'.
symbol(orange,X) :- X='O'.

% is_orthogonal(+Position1, +Position2)
% Define predicates to check if two positions are orthogonal.
is_orthogonal(_-Row,_-Row).
is_orthogonal(Col-_,Col-_).

% are_equal(+X, +X)
% Define a predicate for checking if two values are equal.
are_equal(X, X).

% next_player(+Player, -NextPlayer)
% Define a predicate to get the next player.
next_player(playerX, playerO).
next_player(playerO, playerX).

% init_state(+Size, -GameState)
% Initialize the game state with a 5x5 board and starting player.
init_state(5, [[
    [empty,o,empty,empty,empty],
    [x,empty,o,empty,empty],
    [empty,x,plus,o,empty],
    [empty,empty,x,empty,o],
    [empty,empty,empty,x,empty]
],playerX]).

% init_state(+Size, -GameState)
% Initialize the game state with a 7x7 board and starting player.
init_state(7, [[
    [empty,o,empty,empty,empty,empty,empty],
    [x,empty,o,empty,empty,empty,empty],
    [empty,x,empty,o,empty,empty,empty],
    [empty,empty,x,plus,o,empty,empty],
    [empty,empty,empty,x,empty,o,empty],
    [empty,empty,empty,empty,x,empty,o],
    [empty,empty,empty,empty,empty,x,empty]
],playerX]).

% init_state(+Size, -GameState)
% Initialize the game state with a 9x9 board and starting player.
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

% colors_positions(+Size, -Colors)
% Define positions of different colors for a 5x5 board.
colors_positions(5, [
    [red, white, purple, black, green],
    [green,red, white, purple, black],
    [black, green, red, white, purple],
    [purple, black, green, red, white],
    [white, purple, black, green, red]
]).

% colors_positions(+Size, -Colors)
% Define positions of different colors for a 7x7 board.
colors_positions(7, [
    [red, yellow, violet, orange, cyan, white, purple],
    [purple, red, yellow, violet, orange, cyan, white],
    [white, purple, red, yellow, violet, orange, cyan],
    [cyan, white, purple, red, yellow, violet, orange],
    [orange, cyan, white, purple, red, yellow, violet],
    [violet, orange, cyan, white, purple, red, yellow],
    [yellow, violet, orange, cyan, white, purple, red]
]).

% colors_positions(+Size, -Colors)
% Define positions of different colors for a 9x9 board.
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