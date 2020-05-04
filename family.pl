% family.pl
person(john).
person(jeff).
person(mary).
person(yulia).
person(joseph).
person(wilhelm).

-male(X) :- female(X).

female(mary).
female(yulia).

-female(X) :- male(X).

person(X) :- male(X).
person(X) :- female(X).

% X is not a person if I have no reason to believe that they are.
% closed world or open world assumption
-person(X) :- not person(X), object(X).

#show person/1.
