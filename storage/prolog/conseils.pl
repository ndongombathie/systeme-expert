:- consult(regles).

conseil('Changer de filière ou de spécialité si nécessaire.') :-
    changement_filere.

conseil('Organiser des séances de révision hebdomadaires pour les matières faibles.') :-
    nb_ue_echouees(N), N >= 2.

conseil('Consulter régulièrement les enseignants pour un suivi personnalisé.') :-
    nb_ue_echouees(N), N >= 2.

conseil('Constituer un groupe de travail avec d''autres étudiants.') :-
    nb_ue_echouees(N), N >= 3.

conseil('Envisager un tutorat individuel pour les matières critiques.') :-
    nb_ue_echouees(N), N >= 3.


conseil(Msg) :-
    credits_annuels(C),
    C < 60,
    Manquants is 60 - C,
    format(string(Msg), 'Il vous manque ~w crédits pour valider l''année. Concentrez-vous sur les UE non validées.', [Manquants]).

conseil('Prioriser les UE à fort coefficient pour maximiser vos chances de validation.') :-
    credits_annuels(C), C >= 30, C < 60.

conseil('Identifier les UE les plus accessibles pour récupérer rapidement des crédits.') :-
    credits_annuels(C), C < 30.


conseil(Msg) :-
    moyenne_annuelle(M),
    M < 10,
    format(string(Msg), 'Votre moyenne générale est de ~2f/20. Objectif: atteindre au moins 10/20.', [M]).

conseil('Augmenter votre temps de travail personnel (minimum 2h par jour).') :-
    moyenne_annuelle(M), M < 9.

conseil('Refaire tous les exercices de TD et TP pour mieux assimiler.') :-
    moyenne_annuelle(M), M < 9.

conseil('Assister à tous les cours et prendre des notes détaillées.') :-
    moyenne_annuelle(M), M < 10.


conseil('Préparez-vous sérieusement aux examens de rattrapage. C''est votre dernière chance.') :-
    autorise_rattrapage.

conseil('Refaire les annales et sujets d''examens des années précédentes.') :-
    autorise_rattrapage.

conseil('Planifier un calendrier de révision strict pour les rattrapages.') :-
    autorise_rattrapage.

conseil('Excellente performance ! Continuez sur cette lancée.') :-
    passage_automatique.

conseil('Approfondir vos connaissances pour préparer le niveau supérieur.') :-
    passage_automatique.


conseil('Passage conditionnel obtenu. Validez les UE manquantes au prochain semestre.') :-
    passage_conditionnel.

conseil('Restez rigoureux dans votre travail pour sécuriser votre passage définitif.') :-
    passage_conditionnel,
    moyenne_annuelle(M), M >= 10.

conseil('Redoublez d''efforts pour améliorer votre moyenne et valider toutes les UE.') :-
    passage_conditionnel,
    moyenne_annuelle(M), M < 10.


conseil('Redoublement nécessaire. Profitez-en pour consolider vos bases.') :-
    redoublement.

conseil('Analysez vos erreurs et adoptez une nouvelle méthode de travail.') :-
    redoublement.

conseil('Sollicitez un entretien pédagogique pour comprendre vos difficultés.') :-
    redoublement.

conseil('Établissez un planning de travail réaliste et tenez-vous y.') :-
    redoublement.


conseil('Participez activement en cours et posez des questions.') :-
    moyenne_annuelle(M), M < 12.

conseil('Utilisez des fiches de révision pour synthétiser les notions clés.') :-
    nb_ue_echouees(N), N >= 1.

conseil('Faites des pauses régulières pour optimiser votre concentration.') :-
    nb_ue_echouees(N), N >= 2.


conseils(L) :-
    findall(C, conseil(C), L_avec_doublons),
    list_to_set(L_avec_doublons, L).
