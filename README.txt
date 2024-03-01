##############################################
##                                          ##
##              DICTIONNAIRE                ##
##                                          ##
##############################################

Paul Lemonnier (L3 Informatique)

###

Utilisation du Programme : 

Dans un terminal:

swipl

['dictionnaire.pl'].

un_dico(Dico), ...

###

Description :

#1

Prédicat cherche/2 tel que cherche(Mot, Dico) est vraie si le Mot est dans le dictionnaire.

Exemples :
?- un_dico(Dico), cherche("an", Dico).
Dico = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[])])])]) ;
;
false.
?- un_dico(Dico), cherche("ba", Dico).
false.

#2

Prédicat tous_les_mots/2 tel que tous_les_mots(Dico, ListeMots) est vrai si ListeMots est la liste de tous les mots du dictionnaire

Exemple :
?- un_dico(Dico), tous_les_mots(Dico, L).
Dico = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[])])])]),
L = ["a","an","bac","bar"] ;
;
false.

#3

Prédicat inserer/3 tel que inserer(String, Dico, Dico_) est vrai si Dico_ est le resultat de l'insertion de String dans Dico

Exemple :
?- un_dico(Dico), inserer("baie", Dico, Dico_).
Dico = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[])])])]),
Dico_ = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[]),dic(i,false,[dic(e,true,[])])])])]) ;
;
false.

#4

Prédicat supprimer_v1/3 tel que supprimer_v1(String, Dico, Dico_) est vrai si le dictionnaire Dico_ est le résultat de la suppresion de la chaîne de caractère String dans le dictionnaire Dico simplement en modifiant les étiquettes booléennes

Exemple :
 ?- un_dico(Dico), inserer("baie", Dico, Dico_), supprimer_v1("bar", Dico_, Dico__).
Dico = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[])])])]),
Dico_ = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[]),dic(i,false,[dic(e,true,[])])])])]),
Dico__ = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,false,[]),dic(i,false,[dic(e,true,[])])])])]) ;
;
false.

#5

Prédicat supprimer_v2/3 tel que supprimer_v2(String, Dico, Dico_) est vrai si le dictionnaire Dico_ est le résultat de la suppresion de la chaîne de caractère String dans le dictionnaire Dico en éliminant les noeuds qui ne permettent plus de former des mots.

Exemple :
?- un_dico(Dico), inserer("baie", Dico, Dico_), supprimer_v2("bar", Dico_, Dico__).
Dico = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[])])])]),
Dico_ = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[]),dic(i,false,[dic(e,true,[])])])])]),
Dico__ = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(i,false,[dic(e,true,[])])])])]) ;
;
false.

#6

Prédicat coq_a_l_ane/4 tel que coq_a_l_ane(String1, String2, Dico, Sequence) permet de passer de la chaîne de départ String1 à une chaîne de caractère String2 (qui appartiennent tous deux au dictionnaire) en changeant une lettre à la fois, de telle sorte que tous les mots intermédiaires formant Sequence appartiennent aussi au dictionnaire.

Exemple :
?- un_dico(Dico), inserer("baie", Dico, Dico_), inserer("brie", Dico_, Dico__), inserer("rive", Dico__, Dico___), coq_a_l_ane("baie", "rive", Dico___, Sequence).
Dico = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[])])])]),
Dico_ = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[]),dic(i,false,[dic(e,true,[])])])])]),
Dico__ = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[]),dic(i,false,[dic(e,true,[])])]),dic(r,false,[dic(i,false,[dic(e,true,[])])])])]),
Dico___ = dic(*,false,[dic(a,true,[dic(n,true,[])]),dic(b,false,[dic(a,false,[dic(c,true,[]),dic(r,true,[]),dic(i,false,[dic(e,true,[])])]),dic(r,false,[dic(i,false,[dic(e,true,[])])])]),dic(r,false,[dic(i,false,[dic(v,false,[dic(e,true,[])])])])]),
Sequence = ["baie","brie","rive"] ;
;
false.