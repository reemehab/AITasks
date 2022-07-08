deletiveEditing(State,Goal):-
	path([State],Goal).

	path([H|_],H):-
	!.
	path([H|T],Goal):-
		getBestChild(H,Goal,T,Output),
		append(T,Output,New_Output),
		path(New_Output,Goal).

	heuristic(_,[]):-
	!.
	heuristic([H|T],[L|T1]):-
		(H=L->heuristic(T,T1);heuristic(T,[L|T1])),!.

	move(State,NEXT,Y):-
		delete(Y,State,NEXT).
		
	delete(X,[X|T],T):-!.
	delete(X,[Y|T],[Y|T1]):-
		delete(X,T,T1).

	moves(State,Goal,Open,Next):-
		isletter(X),
		member(X,State),
		not(member(State,Open)),
		heuristic(State,Goal),
		move(State,Next,X).

	getBestChild(State,Goal,Open,Output):-
		findall(NextState,moves(State,Goal,Open,NextState),Output).

	isletter('A').
	isletter('B').
	isletter('C').
	isletter('D').
	isletter('E').
	isletter('F').
	isletter('G').
	isletter('H').
	isletter('I').
	isletter('J').
	isletter('K').
	isletter('L').
	isletter('M').
	isletter('N').
	isletter('O').
	isletter('P').
	isletter('Q').
	isletter('R').
	isletter('S').
	isletter('T').
	isletter('U').
	isletter('V').
	isletter('W').
	isletter('U').
	isletter('X').
	isletter('Y').
	isletter('Z').