:- use_module(library(between)).

% read_number(-Number)
% Read a number from user input without dot.
read_number(X):-
    read_number_aux(X,0).
read_number_aux(X,Acc):- 
    get_code(C),
    between(48, 57, C), !,
    Acc1 is 10*Acc + (C - 48),
    read_number_aux(X,Acc1).
read_number_aux(X,X).

% read_cont(-Atom, +Acc)
% Read a continuous sequence of characters until a newline (enter) is found. (Without dot)
read_cont(X, Acc):-
    get_char(Input),
    Input \= '\n',
    append(Acc, [Input], Acc1),
    read_cont(X, Acc1).
read_cont(X, Acc):-
    atom_chars(X, Acc).

% player_name(+Player)
% Read a player's name from input and assert it in the knowledge base.
player_name(Player):-
    read_cont(Name, []),
    asserta(get_name(Player, Name)).

% set_piece(+Board, +Col-Row, +Piece, -NewBoard)
% Set a piece on the game board at a specific column and row.
set_piece(Board, Col-Row, Piece, NewBoard) :-
    set_element(Board, Row, Col, Piece, NewBoard).

% set_element(+Board, +RowIndex, +Col, +Piece, -NewBoard)
% Set a piece on the game board at a specific column and row.
set_element([], _, _, _, []).
set_element([Row|Rest], 1, Col, Piece, [NewRow|Rest]) :-
    set_column(Row, Col, Piece, NewRow).
set_element([Row|Rest], RowIndex, Col, Piece, [Row|NewRest]) :-
    RowIndex > 1,
    NextRowIndex is RowIndex - 1,
    set_element(Rest, NextRowIndex, Col, Piece, NewRest).

% set_column(+Row, +Col, +Piece, -NewRow)
% Set a piece on a row at a specific column.
set_column([], _, _, []).
set_column([_|Rest], 1, Piece, [Piece|Rest]).
set_column([X|Rest], Col, Piece, [X|NewRest]) :-
    Col > 1,
    NextCol is Col - 1,
    set_column(Rest, NextCol, Piece, NewRest).

% initialize_cube_position(+N)
% Initialize the position of a cube on the board.
initialize_cube_position(N) :-
    Pos is N div 2 + 1,
    assert(cube_position(Pos, Pos)).

% get_player_pieces_positions(+GameState, -Positions)
% Get the positions of a player's pieces and the cube on the board.
get_player_pieces_positions([Board, Player], Positions) :-
    length(Board, N),
    findall(Col-Row, (between(1, N, Row), between(1, N, Col), (pick_piece(Board, Col-Row, Piece), (compare_piece(Player, Piece) ; compare_piece(cube, Piece)))), Positions).

% get_player_pieces_positions_without_cube(+GameState, -Positions)
% Get the positions of a player's pieces on the board, excluding the cube.
get_player_pieces_positions_without_cube([Board, Player], Positions) :-
    length(Board, N),
    findall(Col-Row, (between(1, N, Row), between(1, N, Col), (pick_piece(Board, Col-Row, Piece), compare_piece(Player, Piece))), Positions).

% winner_message(+Player)
% Display a message announcing the winner of the game.
winner_message(Player) :-
    get_name(Player, Name),
    write('****************************************'), nl,
    write('Congratulations '), write(Name), write('! You won!'), nl,
    write('****************************************'), nl.

% draw_bot_thinking(+Player)
% Display a message indicating that a bot player is thinking.
draw_bot_thinking(Player) :-
    get_name(Player, Name),
    write('Bot '), write(Name), write(' is thinking...'), nl.

% draw_bot_move(+Player, +Col1-Row1-Col2-Row2)
% Display a message showing the bot's chosen move.
draw_bot_move(Player, Col1-Row1-Col2-Row2) :-
    get_name(Player, Name),
    write('Bot '),
    write(Name),
    write(' chose: '), nl,
    write('----FROM----'), nl,
    write('Row: '), write(Row1), nl,
    write('Column: '), write(Col1), nl,
    write('----TO----'), nl,
    write('Row: '), write(Row2), nl,
    write('Column: '), write(Col2), nl.

% clear_content/0
% Clear all content (facts) in the knowledge base for specific predicates.
clear_content :-
    retractall(get_name(_,_)),
    retractall(cube_position(_,_)),
    retractall(bot_diff(_,_)).
