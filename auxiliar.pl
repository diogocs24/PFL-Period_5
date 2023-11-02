:- use_module(library(between)).

% input without using dot (professor's code)
read_number(X):-
    read_number_aux(X,0).
read_number_aux(X,Acc):- 
    get_code(C),
    between(48, 57, C), !,
    Acc1 is 10*Acc + (C - 48),
    read_number_aux(X,Acc1).
read_number_aux(X,X).

read_cont(Result, Acc):-
    get_char(Char),
    Char \= '\n',
    append(Acc, [Char], Acc1),
    read_cont(Result, Acc1).
read_cont(Result, Acc):-
    atom_chars(Result, Acc).

player_name(Player):-
    read_cont(Name, []),
    asserta(name_of(Player, Name)).
