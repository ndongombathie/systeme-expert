:- consult(faits).
:- dynamic ec/3.
% ec(UE, EC, Note)


moyenne_ue(UE, Moy) :-
    findall(N, ec(UE, _, N), L),
    L \= [],
    sum_list(L, S),
    length(L, Nbr),
    Nbr > 0,
    Moy is S / Nbr.

ue_validee(UE) :-
    moyenne_ue(UE, M),
    M >= 10.

ue_non_validee(UE) :-
    moyenne_ue(UE, M),
    M < 10.

credits_ue(UE, C) :-
    ue(UE, _, _, _, C, _),
    ue_validee(UE).

credits_ue(UE, 0) :-
    ue(UE, _, _, _, _, _),
    \+ ue_validee(UE).

% CORRECTION ICI : Ne compter que les UE avec des notes
credits_annuels(Total) :-
    findall(UE, ec(UE, _, _), UEs_avec_notes),
    list_to_set(UEs_avec_notes, UEs_uniques),
    findall(C, (member(UE, UEs_uniques), credits_ue(UE, C)), L),
    sum_list(L, Total).


moyenne_annuelle(Moy) :-
    findall(MC,
        ( ue(UE, _, _, _, _, Coef),
          moyenne_ue(UE, M),
          MC is M * Coef ),
        L),
    L \= [],
    findall(Coef, (ue(UE, _, _, _, _, Coef), moyenne_ue(UE, _)), Coefs),
    sum_list(L, Num),
    sum_list(Coefs, Den),
    Den > 0,
    Moy is Num / Den.

passage_automatique :- credits_annuels(60).

passage_conditionnel :-
    credits_annuels(C), C >= 42, C < 60.

autorise_rattrapage :-
    moyenne_annuelle(M), M >= 9, M < 10.

redoublement :-
    credits_annuels(C), C < 42.

nb_ue_echouees(N) :-
    findall(UE, ue_non_validee(UE), L),
    length(L, N).

decision(D, J) :-
    ( passage_automatique ->
        D = 'Passage automatique',
        J = 'Tous les crédits validés (60/60)'
    ; passage_conditionnel ->
        D = 'Passage conditionnel',
        J = 'Crédits partiellement validés (42/60)'
    ; autorise_rattrapage ->
        D = 'Rattrapage',
        J = 'Moyenne annuelle proche de 10'
    ; redoublement ->
        D = 'Redoublement',
        J = 'Crédits insuffisants'
    ).
