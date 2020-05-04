% Final Exam Prolog Graph
node(v1, v2, v3, s, t).

edge(v1, t).
edge(v2, v1).
edge(s, v1).
edge(s, v2).
edge(v3, v2).
edge(s, v3).

cost(v1, t, 20).
cost(v2, v1, 2).
cost(s, v1, 18).
cost(s, v2, 1).
cost(v3, v2, 1).
cost(s, v3, 1).

path(X,Y) :- edge(X,Y).
path(X,Z) :- edge(X,Y), path(Y,Z).
hasCycle(X) :- path(X,X).

reachable(X,Y) :- path(X,Y), cost(X,Y,1).

%#show cost/3.
%#show hasCycle/1. % the graph does not have a cycle.
#show reachable/2.
