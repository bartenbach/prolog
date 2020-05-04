%
% time is measured in discrete steps from 0 to n.
#const n = 12.
time(0..n).

block(b0;b1;b2;b3;b4;b5;b6;b7).

% located on the table
location(table).
% on top of another block
location(B) :- block(B).
              
% fluents
% Block B is on location L
fluent(on(B,L)) :- block(B), location(L), B != L.
% a block is considered to be occupied if it has another on top of it.
holds(occupied(B1), T) :- 
  holds(on(B2,B1), T),
  block(B1), block(B2),
  B1 != B2.

-holds(occupied(B), T) :-
  not holds(occupied(B), T),
  block(B), time(T).

% actions
% represents the action of placing a block at or on a particular location
action(put(B,L)) :- block(B), location(L), B != L.

% the initial state
% it holds that a is on the table at moment zero
holds(on(b0,table), 0).
holds(on(b3,b0), 0).
holds(on(b2,b3), 0).
holds(on(b1,table), 0).
holds(on(b4,b1), 0).
holds(on(b5,table), 0).
holds(on(b6,b5), 0).
holds(on(b7,b6), 0).

% only the inital state
-holds(on(B,L), 0) :-
  not holds(on(B,L),0),
  fluent(on(B,L)).

% inertia axioms
holds(F, T + 1) :-
  holds(F, T),
  not -holds(F, T + 1),
  T < n.

-holds(F, T + 1) :-
  -holds(F, T),
  not holds(F,T + 1),
  T < n.

% effects of actions
% putting an object on a location causes that object to now be on that location
% **********
holds(on(B,L), T + 1) :-
  occurs(put(B,L), T),
  fluent(on(B,L)),
  action(put(B,L)),
  T < n.

% a block can only be at one locatin at any particular moment of time
-holds(on(B,L1), T) :-
  holds(on(B,L2), T),
  fluent(on(B,L1)),
  fluent(on(B,L2)),
  L1 != L2.

% it is not possible to put a block onto an occupied location
:- occurs(put(B,L), T), holds(occupied(L), T).

% it is not possible to move an occupied block
:- occurs(put(B,L), T), holds(occupied(B), T).

% Planning Module
goal :- 
  goal(T),
  time(T).

goal(T) :-
  holds(on(b0,table), T),
  holds(on(b1,b0), T),
  holds(on(b2,b1), T),
  holds(on(b3,b2), T),
  holds(on(b4,b3), T),
  holds(on(b5,b4), T),
  holds(on(b6,b5), T),
  holds(on(b7,b6), T),
  time(T).

1{occurs(A,T) : action(A)}1 :- not goal(T), time(T).

:- not goal.

%occurs(put(b6,table), 0).

% solver directives
#show occurs/2.
%#show -holds/2.

% challenge: write the same program in java in 130 lines or less
