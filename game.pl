:- dynamic last_move/2.

game_init(Player1, Player2) :-
    print_board,
    game_loop(Player1, Player2, 1). %implementar o loop do jogo

game_loop(Player1, Player2, Player) :-
    get_move(Player, Move). % Obtém a jogada do jogador atual.
    %apply_move(Board, Move, Player, NewBoard), % Aplica a jogada ao tabuleiro.
    %check_winner(NewBoard, Player) -> % Verifica se o jogador atual venceu.
    %       write('Player '), write(Player), write(' wins!\n')
    %; 
        % Alterna para o próximo jogador e continua o jogo.
    %NextPlayer is 3 - Player, % Switch between players 1 and 2.
    %    game_loop(Player1, Player2, NextPlayer).
    
% Combinações possiveis para ganhar um jogo
%winning_combination()
%check_winner(Board, Player) :- 

get_move(Player, Move) :-
    repeat,
    write('Player '), write(Player), write(', please enter your move (e.g., "3,2"): '),
    read(Move),
    (valid_move(Player, Move) ->
        ! % Jogada válida, sai do loop repeat
    ; 
        writeln('Invalid move. Please try again.') % Jogada inválida, exibe mensagem e continua o loop repeat
    ).

valid_move(Player, Move) :-
    % verifica se a jogada é válida dentro do tabuleiro
    Move = [Row, Col],
    between(1, 5, Row),
    between(1, 5, Col),
    
    % verifica se a jogada não é a mesma que anterior
    \+ last_move(Player, Move),
    
    % Update the last move for the player.
    retractall(last_move(Player, _)), % retira a ultima jogada do jogador 
    assertz(last_move(Player, Move)). % adiciona a nova jogada do jogador


    