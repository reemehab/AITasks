threeSum(StratState,Goal,Output):-
	StratState =[H|T],
	getHeuristic(StratState,Goal,0,He),
	search([[[H|T],0,[],0,He]],[],Goal,Output).
		
search([],Closed,Goal,Output):- % base case
    getBestChild(Open, BestChild, _),
	BestChild = [_,Sum,Set,Counter,He],
	He = 0,
    !,false. 
search(Open, Closed, Goal,Output):-
	Open \= [],
    	Open = [State|RestOfOpen],
	State = [_,Sum,Set,Counter,He],
	( Counter < 3 ->
	getBestChild(Open, BestChild, RestOfOpen),
	getAllValidChildren(BestChild, Open, Closed,Goal, Children),
	append(Children,RestOfOpen, NewOpen), %DFS
	append([BestChild], Closed, NewClosed), !,
	search(NewOpen, NewClosed, Goal,Output);
	Sum=:=Goal,
	reverse(Set,New_Set),
        Output=New_Set
	).

search(Open, Closed, Goal,Output):- % case of counter is 3 and not the goal
	Open \= [],
	Open = [State|RestOfOpen],		% bnkml b rest of open
	State = [_,Sum,Set,Counter,_],
	    append([State], Closed, NewClosed),
	search(RestOfOpen,NewClosed,Goal,Output).

getAllValidChildren(State, Open, Closed,Goal, Children):-
	findall(X, getNextState(State, Open, Closed,Goal, X), Children), !.
	
getNextState(State, Open, Closed,Goal,NextState):-
	move(State, NextState),
	State = [_,Sum,Set,Counter,_],
	not(member([NextState,_,_,_,_], Open)),
	not(member([NextState,_,_,_,_], Closed)),
    NextState =[L,_,_,_,_], 
	getHeuristic(L,Goal,Sum,New_he),
	NextState = [_,_,_,_,New_he].

move(State, NextState):-
	State =[[H|T],Sum,Set,Counter,_],
	New_Counter is Counter + 1,
	New_Sum is Sum+H,
	append([H],Set,New_Set),
	NextState=[T,New_Sum,New_Set,New_Counter,_].
	
move(State,NextState):-
	State=[[_|T],Sum,Set,Counter,_],
	NextState=[T,Sum,Set,Counter,_], !.

substitute(Old, [Old|T], New, [New|T]):- !.
substitute(Old, [H|T], New, [H|NewT]):-
	substitute(Old, T, New, NewT).


getBestChild(Open, BestChild, RestOfOpen):-
	findMin(Open, BestChild),
	removeFromList(BestChild,Open, RestOfOpen).


findMin([X], X):- !.

findMin([H|T], Min):-
	findMin(T, TmpMin),
	H = [_,_,_,_,HFn],
	TmpMin = [_,_,_,_, TmpFn],
	(TmpFn < HFn -> Min = TmpMin 
					; Min = H).

getHeuristic([],Goal,Sum,He):-

    (Goal - Sum <0 ->
   He is 10000
    ;   
    He is Goal - Sum
    ),
    !.

getHeuristic([H|T],Goal,Sum,He):-
	New_sum is H + Sum,
getHeuristic(T,Goal,New_sum,He),!.



removeFromList(_, [], []).

removeFromList(H, [H|T], V):-

	!, removeFromList(H, T, V).

removeFromList(H, [H1|T], [H1|T1]):-

	removeFromList(H, T, T1).