game_init(Player1, Player2) :-
    print_board,
    game_loop(Player1, Player2, 1). %implementar o loop do jogo