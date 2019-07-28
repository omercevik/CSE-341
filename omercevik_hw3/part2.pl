%		   CSE 341
%	Programming Languages
%	 	 Homework 3
%		   Part 2
%		 Omer Cevik
%		  161044004

flightSwap(istanbul,izmir,3).
flightSwap(edirne,erzurum,5).
flightSwap(erzurum,antalya,2).
flightSwap(antalya,diyarbakir,5).
flightSwap(antalya,izmir,1).
flightSwap(izmir,ankara,6).
flightSwap(istanbul,ankara,2).
flightSwap(istanbul,trabzon,3).
flightSwap(trabzon,ankara,6).
flightSwap(ankara,kars,3).
flightSwap(kars,gaziantep,3).
flightSwap(diyarbakir,ankara,8).

flight(X,Y,C) :- flightSwap(X,Y,C); flightSwap(Y,X,C).	% Checks X or Y.

route(X,Y,C) :- flight(X,Y,C).				% Base for route.
route(X,Y,C) :- costevaluater(X,Y,C,[]).	% Cost evaluation call.

costevaluater(X,Y,C,_) :- flight(X,Y,C).	% Cost evaluation base case.
costevaluater(X,Y,C,List) :- \+ member(X,List), flight(X,Z,A), costevaluater(Z,Y,B,[X|List]), X\=Y, C is A + B.	% Cost evaluation recursively using list.