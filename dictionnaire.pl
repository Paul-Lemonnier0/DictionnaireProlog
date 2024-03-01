:- debug.
:- set_prolog_flag(answer_write_options, [quoted(true), portray(true), max_depth(100), attributes(portray)]). 

un_dico(dic('*', false, [
		dic('a', true, [
			dic('n', true, [])
		]),
		dic('b', false, [
			dic('a', false, [
				dic('c', true, []),
				dic('r', true, [])
			])
		]),
		
		dic('c', true, [])
	])
).


%% Exercice 1

mot_accepter([A], dic(A, true, _)).
mot_accepter([X | L], dic(X, _, [D | DL])):-
	mot_accepter(L, D);
	mot_accepter([X | L], dic(X, false, DL)).


cherche(M, dic('*', true, _)):-
	string_chars(M, []).
	
cherche(M, dic('*', _, [D | DL])) :-
	cherche(M, dic('*', false, DL)) ; 
	mot_accepter(X, D),
	string_chars(M, X).



%% Exercice 2



conc([], L2, L2). 
conc([X | L1], L2, [X | L3]) :- 
   conc(L1, L2, L3).

concatMot(_, [], []).
concatMot(C, [X | L], [Y | LM]):-
	concatMot(C, L, LM), string_concat(C, X, Y).

tous_les_mots_d_une_branche(dic(A, true, []), [A_]):-
	string_concat(A, "", A_).
	
tous_les_mots_d_une_branche(dic(_, false, []), []).

tous_les_mots_d_une_branche(dic(A, true, [D | DL]), Result):-
    tous_les_mots_d_une_branche(D, BL),
    tous_les_mots_d_une_branche(dic(A, true, DL), LR),
	concatMot(A, BL, Res),
	conc(Res, LR, Result).

tous_les_mots_d_une_branche(dic(A, false, [D | DL]), Result):-
    tous_les_mots_d_une_branche(D, BL),
    tous_les_mots_d_une_branche(dic(A, false, DL), LR),
	concatMot(A, BL, Res),
	conc(Res, LR, Result).


tous_les_mots(dic('*', true, []), [""]).
tous_les_mots(dic('*', false, []), []).

tous_les_mots(dic('*', Bool, [D | DL]), Res):-
    tous_les_mots_d_une_branche(D, BW),
    tous_les_mots(dic('*', Bool, DL), LR),
	conc(BW, LR, Res).


%% Exercice 3

non_vide([_ | _]).

inserer_lettre([A], [], [dic(A, true, [])]).
inserer_lettre([A | R], [], [dic(A, false, Res)]) :-
	non_vide(R),
	inserer_lettre(R, [dic(A, false, [])], Res).

inserer_lettre([A], [dic(A, _, SubDL) | DL], [dic(A, true, SubDL) | DL]).

inserer_lettre([A | R], [dic(A, B, SubDL) | DL], Resultat):-
	non_vide(R),
	inserer_lettre(R, SubDL, Res),
	conc([dic(A, B, Res)], DL, Resultat).

inserer_lettre([X], [dic(Y, B, SubDL) | DL], Resultat):-
	\+(X=Y),
	inserer_lettre([X], DL, Res),
	conc([dic(Y, B, SubDL)], Res, Resultat).

inserer_lettre([X | R], [dic(Y, B, SubDL) | DL], [dic(Y, B, SubDL) | Res]):-
	\+(X=Y),
	non_vide(R),
	inserer_lettre([X | R], DL, Res).


inserer("", dic('*', _, DL), dic('*', true, DL)).

inserer(String, dic('*', B, DL), dic('*', B, DL_)):-
	string_chars(String, SC),
	inserer_lettre(SC, DL, DL_).


%% Exercice 4



supprimer_lettre([_], [], []).
supprimer_lettre([A], [dic(A, _, SubDL) | DL], [dic(A, false, SubDL) | DL]).
supprimer_lettre([X], [dic(Y, B, SubDL) | DL], Resultat):-
	\+(X=Y),
	supprimer_lettre([X], DL, Res),
	conc([dic(Y, B, SubDL)], Res, Resultat).

supprimer_lettre([A | R], [], [dic(A, false, Res)]) :-
	non_vide(R),
	supprimer_lettre(R, [dic(A, false, [])], Res).

supprimer_lettre([A | R], [dic(A, B, SubDL) | DL], Resultat):-
	non_vide(R),
	supprimer_lettre(R, SubDL, Res),
	conc([dic(A, B, Res)], DL, Resultat).

supprimer_lettre([X | R], [dic(Y, B, SubDL) | DL], [dic(Y, B, SubDL) | Res]):-
	\+(X=Y),
	non_vide(R),
	supprimer_lettre([X | R], DL, Res).


supprimer_v1("", dic('*', _, DL), dic('*', true, DL)).

supprimer_v1(String, dic('*', B, DL), dic('*', B, DL_)):-
	string_chars(String, SC),
	supprimer_lettre(SC, DL, DL_).


%% Exercice 5



supprimer_v2_lettre([_], [], []).
supprimer_v2_lettre([A], [dic(A, _, _) | DL], DL).
supprimer_v2_lettre([X], [dic(Y, B, SubDL) | DL], Resultat):-
	\+(X=Y),
	supprimer_v2_lettre([X], DL, Res),
	conc([dic(Y, B, SubDL)], Res, Resultat).

supprimer_v2_lettre([A | R], [], [dic(A, false, Resultat)]):-
	non_vide(R),
	supprimer_v2_lettre(R, [], Resultat).

supprimer_v2_lettre([A | R], [dic(A, B, SubDL) | DL], Resultat):-
	non_vide(R),
	supprimer_v2_lettre(R, SubDL, Res),
	conc([dic(A, B, Res)], DL, Resultat).

supprimer_v2_lettre([X | R], [dic(Y, B, SubDL) | DL], [dic(Y, B, SubDL) | Res]):-
	\+(X=Y),
	non_vide(R),
	supprimer_v2_lettre([X | R], DL, Res).

supprimer_v2("", dic('*', _, DL), dic('*', true, DL)).

supprimer_v2(String, dic('*', B, DL), dic('*', B, DL_)):-
	string_chars(String, SC),
	supprimer_v2_lettre(SC, DL, DL_).



%% Exercice 6


%% Vrai si N est la longueur de la liste (donne la longueur d une liste)

longueur([_],1).
longueur([_|L],N):- longueur(L,N1), N is N1+1.

%% string en tab

tab_to_string(S_Tab, S):- string_chars(S, S_Tab).

%% Vrai si une lettre est dans le tab de lettre donné en parametre

lettre_dans_tab_mot(X,[X|_L]).
lettre_dans_tab_mot(X,[_Y|L]):- lettre_dans_tab_mot(X,L).
   
%% Concatene 2 mots en omettant les doublons

union_mots([], M_Tab2, M_Tab2).

union_mots([C | M_Reste1], M_Tab2, M_Tab12) :-
	lettre_dans_tab_mot(C, M_Tab2),
	union_mots(M_Reste1, M_Tab2, M_Tab12).

union_mots([C | M_Reste1], M_Tab2, [C | M_Tab12]) :-
    \+ lettre_dans_tab_mot(C, M_Tab2),
	union_mots(M_Reste1, M_Tab2, M_Tab12).


%% Vrai si M1 et M2 ont une seul lettre de différence

une_lettre_change(M1, M2):-
	string_chars(M2, M2_String),
	union_mots(M1, M2_String, M12_String),
	longueur(M12_String, M12_String_Long),
	longueur(M1, M1_Long),
	Long is M1_Long+1,
	Long = M12_String_Long.

%% Renvoie tous les mots de memes taille que S_Tab dans la Liste 

tous_les_mots_meme_taille(S_Tab, [M], []):-
    longueur(S_Tab, SL),
    string_chars(M, M_Tab),
    longueur(M_Tab, ML),
    \+(SL = ML).

tous_les_mots_meme_taille(S_Tab,[M],[M_Tab]):-
    longueur(S_Tab, SL),
    string_chars(M, M_Tab),
    longueur(M_Tab, ML),
    SL = ML.

tous_les_mots_meme_taille(S_Tab, [M | MR], [M_Tab | Resultat]) :-
	tous_les_mots_meme_taille(S_Tab, MR, Resultat),
	longueur(S_Tab, SL),
	string_chars(M, M_Tab),
	longueur(M_Tab, ML),
	SL = ML.

tous_les_mots_meme_taille(S_Tab, [M | MR], Resultat) :-
	tous_les_mots_meme_taille(S_Tab, MR, Resultat),
	longueur(S_Tab, SL),
	string_chars(M, M_Tab),
	longueur(M_Tab, ML),
	\+(SL = ML).


%% Renvoie la liste de mot sans le mot X

liste_sans_X(_,[],[]).
liste_sans_X(X,[M | R],[ M | Resultat]):-
    string_chars(M, M_Tab),
    \+(M_Tab=X),
    liste_sans_X(X, R, Resultat).
liste_sans_X(X,[M | R], Resultat):-
    string_chars(M, M_Tab),
    M_Tab=X,
    liste_sans_X(X, R, Resultat).

%% Appel coq_a_l_ane avec le mot courant de la liste qui a une lettre d ecart 

coq_a_l_ane_body(MotDepart, [Mot], S_Tab, ListeMots, Sequence) :-
	une_lettre_change(MotDepart, Mot),
	coq_a_l_ane(Mot, S_Tab, ListeMots, Sequence).

coq_a_l_ane_body(MotDepart, [Mot | R], S_Tab, ListeMots, Sequence) :-
	non_vide(R),
	une_lettre_change(MotDepart, Mot),
	coq_a_l_ane(Mot, S_Tab, ListeMots, Sequence);
	non_vide(R),
	coq_a_l_ane_body(MotDepart, R, S_Tab, ListeMots, Sequence).


coq_a_l_ane(_,_,[],[]).
coq_a_l_ane(S_Tab, S_Tab, [_|_], [S]) :-
	tab_to_string(S_Tab, S).

coq_a_l_ane(String_Tab1, String_Tab2, ListeMots, [String1 | Sequence]):-
	\+(String_Tab1 = String_Tab2),
	tab_to_string(String_Tab1, String1),
	liste_sans_X(String_Tab1, ListeMots, ListeSansString_Tab1),
	coq_a_l_ane_body(String_Tab1, ListeSansString_Tab1, String_Tab2, ListeSansString_Tab1, Sequence).

coq_a_l_ane(String1, String2, Dico, Sequence):-
	string_chars(String1, String_tab1),
	string_chars(String2, String_tab2),
	tous_les_mots(Dico, Listemots),
	tous_les_mots_meme_taille(String_tab1, Listemots, ListeMotsMemeTaille),
	coq_a_l_ane(String_tab1, String_tab2, ListeMotsMemeTaille, Sequence).

