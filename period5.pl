:- consult('menu.pl').
:- consult('display.pl').
:- use_module(library(lists)).
:- use_module(library(random)).

period5 :-     
      firstMenu,
      initial_board(Board),
      printBoard(Board).
      
      
