%
% time is enumerated from 0 up to some n
#const n = 1.
time(0..1).

block(a;b;c;d;e).

% located on the table
location(table).
% on top of another block
location(X) :- block(B), location(X).
              
% fluents
fluent(on(B,L)) :- block(B), location(L), B != L.
fluent(occupied(B)) :- block(B).

% actions
action(put(B,L)) :- block(B), location(L), B != L.

% the initial state
% it holds that a is on the table at moment zero
holds(on(a,table), 0).
holds(on(e,table), 0).
holds(on(c,table), 0).
holds(on(d,c),     0).
holds(on(b,d),     0).

% only the inital state
-holds(F,0) :-
  not holds(F,0),
  fluent(F).

  % the table can never be occupied
-holds(occupied(table), T) :- time(T).

holds(occupied(B1), T) :- 
  holds(on(B2,B1), T),
  block(B1), block(B2),
  time(T).

% inertia axioms
holds(F, T + 1) :-
  holds(F,T),
  not -holds(F,T),
  fluent(F), time(T).

-holds(F, T + 1) :-
  -holds(F,T),
  not holds(F,T),
  fluent(F), time(T).

-holds(occupied(B),T) :-
  not holds(occupied(B),T),
  block(B), time(T).

% effects of actions
% putting an object on a location causes that object to now be on that location
holds(on(B,L), T+1) :-
  occurs(put(B,L), T),
  block(B), location(L), time(T).

% an occupied block cannot be placed on any location
:- occurs(put(B,L), T), holds(occupied(B), T),
  time(T), action(put(B,L)), fluent(occupied(B)).

% a block cannot be placed on an occupied location
:- occurs(put(B,L), T), holds(occupied(L), T),
  time(T), action(put(B,L)), fluent(occupied(L)).

% scenario 1
occurs(put(b,table), 1).

% solver directives
#show holds/2.
#show -holds/2.
