%%%%%%%%%% 01 %%%%%%%%%%
gcd(0,X,X):-!. 
gcd(X,0,X):-!. 
gcd(A, B, G) :- A =< B, !,        
    D is B - A,                   
    gcd(D, A, G).
gcd(A, B, G) :- A > B, !,  
    D is A - B,
    gcd(D, B, G).

%?- gcd(48,18,G).

%%%%%%%%%% 02 %%%%%%%%%%
split([],_,[],[]). 
split([H1|T], H, [H1|A], B) :-                       
    H1 < H, !,                                    
    split(T, H, A, B).
split([H1|T], H, A, [H1|B]) :-                       
    H1 >= H, !,
    split(T, H, A, B).

%?-split([3,2,6,1,5],4,L1,L2).

%%%%%%%%%% 03 %%%%%%%%%%
% Insert Sort
insertsort([],[]). 
insertsort([X|T],S):-insertsort(T,ST),insert(X,ST,S). 
 
% insert(Elem,OrderedList,OrderedList1) -- insert the element Elem on its right 
% position in OrderedList and the result is OrderedList1
% Example. Elem=3, OrderedList=[1,2,6,9] => OrderedList1=[1,2,3,6,9] 

insert(X, [], [X]) :- !.
insert(X, [H|T], [X,H|T]) :-
    X =< H, !.
insert(X, [H|T], [H|NT]) :-
    insert(X, T, NT).

%?- insertsort([4,2,6,1,5,3],L).

% Quick Sort
quick([],[]). 
quick([X],[X]).
quick([H|T], L) :-
    split(T, H, A, B),      
    quick(A, A1),
    quick(B, B1),
    append(A1, [H|B1], L).

%?- quick([3,2,6,1,5], L).

%%%%%%%%%% 04 %%%%%%%%%%
queen([]). 
queen([[X,Y]|S]):-queen(S),member(Y,[1,2,3,4,5,6,7,8]), not(atack([X,Y],S)).
atack([X,Y],[[X1,Y1]|S]):- Y=Y1; abs(X-X1)=:=abs(Y-Y1); atack([X,Y],S).

%? - queen([[1,X1],[2,X2],[3,X3],[4,X4],[5,X5],[6,X6],[7,X7],[8,X8]]).
%? - queen([[1,1],[2,3],[3,5],[4,7],[5,2],[6,4],[7,6],[8,8]]). false one


%%%%%%%%%% 05 %%%%%%%%%%
eliminateOne(X, [X|T], T).
eliminateOne(X, [H|T], [H|R]) :- eliminateOne(X, T, R).

permutations([], []).
permutations(L, [H|T]) :-
    eliminateOne(H, L, R),
    permutations(R, T).

left(X, Y) :- X =:= Y - 1.
next(X, Y) :- X =:= Y + 1; X =:= Y - 1.

einstein(Sol) :- Sol=[[1,N1,C1,P1,D1,S1],   
                      [2,N2,C2,P2,D2,S2], 
                      [3,N3,C3,P3,D3,S3], 
                      [4,N4,C4,P4,D4,S4], 
                      [5,N5,C5,P5,D5,S5]],

% --- clues
% The British man lives in the red house. 
member([_, british, red, _, _, _], Sol),

% The Norwegian lives next to the blue house. 
member([HN, norwegian, _, _, _, _], Sol),
member([HB, _, blue, _, _, _], Sol),
next(HN, HB),

% The green house is to the (immediate) left of the white house.
member([HG, _, green, _, _, _], Sol),
member([HW, _, white, _, _, _], Sol),
left(HG, HW),

% The owner of the green house drinks coffee.
member([_, _, green, _, coffee, _], Sol),

% The owner of the house in the middle drinks milk.
member([3, _, _, _, milk, _], Sol),

% The owner of the yellow house smokes Dunhill.
member([_, _, yellow, _, _, dunhill], Sol),

% The Norwegian lives in the first house.
member([1, norwegian, _, _, _, _], Sol),

% The Swedish man has a dog.
member([_, swedish, _, dog, _, _], Sol),

% The person who smokes Pall Mall has a bird.
member([_, _, _, bird, _, pallmall], Sol),

% The Marlboro smoker lives next to the one with a cat.
member([HM, _, _, _, _, marlboro], Sol),
member([HC, _, _, cat, _, _], Sol),
next(HM, HC),

% The Winfield smoker drinks beer.
member([_, _, _, _, beer, winfield], Sol),

% The person who owns a horse lives next to the one who smokes Dunhill.
member([HH, _, _, horse, _, _], Sol),
member([HD, _, _, _, _, dunhill], Sol),
next(HH, HD),

% The German smokes Rothmans.
member([_, german, _, _, _, rothmans], Sol),

% The Marlboro smoker has a neighbor who drinks water.
member([HMa, _, _, _, _, marlboro], Sol),
member([HWa, _, _, _, water, _], Sol),
next(HMa, HWa),

permutations([N1,N2,N3,N4,N5], [british, swedish, danish, norwegian, german]),
permutations([C1,C2,C3,C4,C5], [red, white, blue, yellow, green]),
permutations([P1,P2,P3,P4,P5], [bird, dog, horse, cat, fish]),
permutations([D1,D2,D3,D4,D5], [milk, beer, tea, water, coffee]),
permutations([S1,S2,S3,S4,S5], [pallmall, winfield, marlboro, dunhill, rothmans]).


% Who owns the fish?
fish_owner(Nationality) :-
    einstein(Sol),
    member([_, Nationality, _, fish, _, _], Sol).

