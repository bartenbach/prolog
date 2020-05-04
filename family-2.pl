% family.pl
person(blake;lita;fred;eloise;lolita;ed;bill,warren).

% X is the parent of Y
parent(blake,warren).
parent(lita,blake).
parent(fred,blake).
parent(eloise,lita).
parent(bill,lita).
parent(lolita,eloise).

% X is an ancestor of Y
ancestor(X,Y) :- parent(X,Y), X != Y.
ancestor(X,Y) :- parent(X,S), ancestor(S,Y),
                person(X), person(Y), person(S),
                X != Y.

#show ancestor/2.
