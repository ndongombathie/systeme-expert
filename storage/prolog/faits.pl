
filiere(informatique).
filiere(physique_chimie).
filiere(sciences_eaux_env).
filiere(math_info).

niveau(l1).
niveau(l2).
niveau(l3).
niveau(m1).
niveau(m2).

% UE(UE, Filiere, Niveau, Semestre, Credits, Coef)

% INFORMATIQUE
ue(algorithmique, informatique, l1, 1, 8, 3).
ue(mathematique, informatique, l1, 1, 8, 3).
ue(physique, informatique, l1, 1, 8, 3).
ue(humanites_et_entreprises, informatique, l1, 1, 6, 2).
ue(reseau_et_systeme, informatique, l2, 2, 6, 2).

ue(systeme_information, informatique, l2, 3, 15, 2).
ue(programmation, informatique, l3, 4, 15, 2).
ue(genie_logiciel, informatique, l3, 5, 15, 2).
ue(informatique, informatique, l3, 6, 15, 2).



% PHYSIQUE-CHIMIE
ue(physique_generale, physique_chimie, l1, 1, 6, 2).
ue(chimie_generale, physique_chimie, l1, 2, 6, 2).
ue(thermodynamique, physique_chimie, l2, 3, 6, 2).
ue(cinetique_chimique, physique_chimie, l2, 4, 6, 2).
ue(physique_quantique, physique_chimie, l3, 5, 6, 2).
ue(chimie_organique, physique_chimie, l3, 6, 6, 2).
ue(physico_chimie, physique_chimie, m1, 1, 6, 2).
ue(chimie_industrielle, physique_chimie, m2, 3, 6, 2).

% SCIENCES DES EAUX ET ENVIRONNEMENT
ue(hydrologie, sciences_eaux_env, l1, 1, 6, 2).
ue(ecologie, sciences_eaux_env, l1, 2, 6, 2).
ue(gestion_eau, sciences_eaux_env, l2, 3, 6, 2).
ue(qualite_eau, sciences_eaux_env, l2, 4, 6, 2).
ue(hydraulique, sciences_eaux_env, l3, 5, 6, 2).
ue(traitement_eaux, sciences_eaux_env, l3, 6, 6, 2).
ue(environnement, sciences_eaux_env, m1, 1, 6, 2).
ue(developpement_durable, sciences_eaux_env, m2, 3, 6, 2).

% MATHEMATIQUES-INFORMATIQUE
ue(analyse, math_info, l1, 1, 8, 3).
ue(algebra_lineaire, math_info, l1, 1, 8, 3).
ue(programmation, math_info, l1, 2, 6, 2).
ue(structures_de_donnees, math_info, l1, 2, 6, 2).
ue(probabilites_statistiques, math_info, l2, 3, 6, 2).
ue(algorithme, math_info, l2, 3, 6, 2).
ue(algebre, math_info, l3, 5, 6, 2).
ue(optimisation, math_info, l3, 5, 6, 2).




