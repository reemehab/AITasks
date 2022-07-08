threeSum(StratState,Goal,Output):-
	StratState =[H|T],
	search([[[H|T],0,[],0]],[],Goal,Output).
	
search([],Closed,Goal,Output):- % base case
    !,false. 
search(Open, Closed, Goal,Output):-
	Open \= [],
	Output=New_Set,
    Open = [State|RestOfOpen],
	State = [_,Sum,Set,Counter],
	( Counter < 3 ->
	getAllValidChildren(State, Open, Closed, Children),
	append(Children,RestOfOpen, NewOpen), %DFS
	append([State], Closed, NewClosed), !,
	search(NewOpen, NewClosed, Goal,Output);
	Sum=:=Goal,
	reverse(Set,New_Set)
	).
	
search(Open, Closed, Goal,Output):- % case of counter is 3 and not the goal
	Open \= [],
	Open = [State|RestOfOpen],		% bnkml b rest of open
	State = [_,Sum,Set,Counter],
    	append([State], Closed, NewClosed),
	search(RestOfOpen,NewClosed,Goal,Output).
	
getAllValidChildren(State, Open, Closed, Children):-
	findall(X, getNextState(State, Open, Closed, X), Children), !.
	
getNextState(State, Open, Closed,NextState):-
	move(State, NextState),
	not(member([NextState,_], Open)),
	not(member([NextState,_], Closed)).

move(State, NextState):-
	State =[[H|T],Sum,Set,Counter],
	New_Counter is Counter + 1,
	New_Sum is Sum+H,
	append([H],Set,New_Set),
	NextState=[T,New_Sum,New_Set,New_Counter].
	
move(State,NextState):-
	State=[[_|T],Sum,Set,Counter],
	NextState=[T,Sum,Set,Counter], !.
