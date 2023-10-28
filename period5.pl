:- consult('menu.pl').
:- consult('content.pl').
:- consult('display_board.pl').
:- use_module(library(lists)).
:- use_module(library(random)).

period5 :-     
      firstMenu,
      print_board.
      
