parent(ion,maria).
parent(ana,maria).
parent(ana,dan).
parent(maria,elena).
parent(maria,radu).
parent(elena,nicu).
parent(radu,george).
parent(radu,dragos).

child(X, Y) :- parent(Y, X).
brother(X, Y) :- parent(X, Z), parent(Y, Z).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

pred(X, Y) :- parent(X, Y).
pred(X, Z) :- parent(X, Y), pred(Y, Z).

%%%%%%%%%% 01 %%%%%%%%%%
maxim(X, Y, Z) :- (   
    X =< Y -> Z = Y
    ; Z = X
).

%%%%%%%%%% 02 %%%%%%%%%%
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

concat([], [], []).
concat([], T, T).
concat(T, [], T).
concat([H|T], L2, [H|R]) :- concat(T, L2, R).

%%%%%%%%%% 03 %%%%%%%%%%
alternate_sum([],0).
alternate_sum([X],X).
alternate_sum([H1,H2|T],R) :- alternate_sum(T,Z), R is Z + H1 - H2.

%%%%%%%%%% 04 %%%%%%%%%%
eliminateOne(X, [X|T], T).
eliminateOne(X, [H|T], [H|R]) :- eliminateOne(X, T, R).

eliminateAll(_, [], []).
eliminateAll(X, [X|T], R) :- eliminateAll(X, T, R).
eliminateAll(X, [H|T], [H|R]) :- eliminateAll(X, T, R).

%%%%%%%%%% 05 %%%%%%%%%%
reverseList([], []).
reverseList([H|T], R) :- reverseList(T, RevT), concat(RevT, [H], R).

permutations([], []).
permutations(L, [H|T]) :-
    eliminateOne(H, L, R),
    permutations(R, T).

%%%%%%%%%% 06 %%%%%%%%%%
numberOccurences(_, [], 0).
numberOccurences(X, [X|T], R) :- numberOccurences(X, T, Z), R is Z + 1.
numberOccurences(X, [_|T], R) :- numberOccurences(X, T, R).

%%%%%%%%%% 07 %%%%%%%%%%
insert(X, 0, L, [X|L]).
insert(X, Pos, L, R) :- 
    Pos > 0,
    Pos1 is Pos - 1,
    L = [H|T],
    insert(X, Pos1, T, R1),
    R = [H|R1].

%%%%%%%%%% 08 %%%%%%%%%%
% Merge two ascending ordered lists. 

merge([], L, L).
merge(L, [], L).
merge([H1|T1], [H2|T2], [H1|R]) :- 
    H1 =< H2,
    merge(T1, [H2|T2], R).
merge([H1|T1], [H2|T2], [H2|R]) :- 
    H1 > H2,
    merge([H1|T1], T2, R).