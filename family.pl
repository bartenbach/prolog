% family.pl
object(john).
object(jeff).
object(mary).
object(yulia).
object(joseph).
object(jon_snow).

male(john).
male(jeff).

-male(X) :- female(X).

female(mary).
female(yulia).

-female(X) :- male(X).

person(X) :- male(X).
person(X) :- female(X).

% X is not a person if I have no reason to believe that they are.
% closed world or open world assumption
-person(X) :- not person(X), object(X).

% upcoming homework will be Einstein's riddle.
