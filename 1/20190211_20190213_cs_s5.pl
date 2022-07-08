%Functions we will use in the Tasks

digit(0,'zero').
digit(1,'one').
digit(2,'two').
digit(3,'three').
digit(4,'four').
digit(5,'five').
digit(6,'six').
digit(7,'seven').
digit(8,'eight'). 	
digit(9,'nine').

memberin(X, [H|T]) :- X = H, !.
memberin(X, [H|T]):- memberin(X,T).
memberin(X, []):- false.

add_tail([],X,[X]).
add_tail([H|T],X,[H|T2]):-
	add_tail(T,X,T2).

add_head(Elem, List, [Elem|List]).

%task_1

studentsInCourse(Course,List):-
	studentsInCourse([],Course,List).

studentsInCourse(TmpList,Course ,List):-
	student(X ,Course, G),
	\+ memberin([X,G],TmpList), !,
	add_tail(TmpList,[X, G],NewList),
	studentsInCourse(NewList ,Course,List).

studentsInCourse(List,Course,List).

%task_2

numStudents(Course, Num):-
	studentsInCourse(Course,List),length(List,Num).

length([],0).
length([H|T],R):-
length(T,R1),
R is 1 + R1.      

%task_3
getmaxStudentGrade(ID,List):-
	getmaxStudentGrade([],ID,List).

getmaxStudentGrade(TmpList,ID ,List):-
	student(ID ,Course, Y),
	\+ memberin(Y ,TmpList),!,
	add_tail(TmpList,Y,NewList),
	getmaxStudentGrade(NewList,ID,List).

getmaxStudentGrade(List,ID,List).

maximum([Max] , Max).
maximum([H1 , H2| T] ,Max ):-
	H1 > H2,
	maximum([H1|T] , Max).

maximum([H1 , H2| T] ,Max ):-
	H1 < H2,
	maximum([H2|T] , Max).

maxStudentGrade(ID , Grade):-
	getmaxStudentGrade(ID , List),
	maximum(List , Grade).

%task_4
gradeInWords(X, Y, DigitsWords):-
     student(X, Y, Grade),
     toWords(Grade,DigitsWords).

toWords(0,List,List).

	toWords(Num,List):-
	toWords(Num,[],List).
toWords(Num, TmpList,List):-
            Num > 0,
	    NMod is Num mod 10,
    		NDiv is Num // 10,    	
    		digit(NMod,X),
		not(memberin(X,TmpList)), !,
                add_head([X], TmpList, NewTmpList),
		toWords(NDiv,NewTmpList,List),!.
toWords(NDiv,List,List).

%task_5

remainingCourses(ID,Course,Courses):-
	getCourses(ID,List),!,
	getRemaningCourses(ID,Course,Courses,List,[]).

getCourses(ID, List):-
	getCourses([],ID,List).

getCourses(TmpList,ID ,List):-
	student(ID ,Course, Grade),
	\+ memberin(Course,TmpList),Grade>=50,!,
	add_tail(TmpList,Course,NewList),
	getCourses(NewList ,ID,List).

getCourses(List,ID,List).

getRemaningCourses(ID,Course,Courses,List,Courses):-
	memberin(Course,List),!.

getRemaningCourses(ID,Course,Courses,List,TmpList):-	
	prerequisite(X,Course),
	\+memberin(Course,List),!,
	Course2 = X,
	((\+memberin(Course2,List),add_head(Course2, TmpList, NewList));NewList=TmpList),!,
	getRemaningCourses(ID,Course2,Courses,List,NewList).

w