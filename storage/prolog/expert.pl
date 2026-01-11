:- consult(faits).
:- consult(regles).
:- consult(conseils).

run(D, J, C) :-
    decision(D, J),
    conseils(C).
