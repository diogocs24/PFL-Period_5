:- consult('menu.pl').
:- consult('content.pl').
:- consult('display_board.pl').
:- consult('auxiliar.pl').
:- consult('game.pl').
:- use_module(library(lists)).
:- use_module(library(random)).

play :-     
      firstMenu(GameState), !,
      game_loop(GameState),
      clear_content.

      
