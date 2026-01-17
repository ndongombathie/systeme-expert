:- consult(regles).

run(N) :- conseils(N).

% L'étudiant inscrit en 1re année peut demander un changement parmi les 3 filières de l'UFR
% Après validation de 60 crédits en LMI1, accès possible en LI2
% Après validation de 60 crédits en LPC1, accès possible en LI2
% si niveau == l1, alors il peut faire un changement de filière
changement_filere :-
    filiere(_),
    niveau(l1).

conseil('si vous etez inscrit dans une filière dès la première année il a la possibilité de faire
une demande de changement de filière parmi les 3 de L’UFR SET') :-
    changement_filere.

conseil('Si l’Etudiant a validé ses 60 crédits en LMI1 il a la possibilité de faire la LI2') :-
    changement_filere.

conseil('Si l’Etudiant a validé ses 60 crédits en LPC1 il a la possibilité de faire la LI2 ') :-
    changement_filere.

conseils(L) :-
    findall(C, conseil(C), L0),
    list_to_set(L0, L).
