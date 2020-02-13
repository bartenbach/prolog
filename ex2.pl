%
color(r).
color(g).
color(b).

node(2).
node(3).
node(4).
node(1).

% bad
%{is(N,C) : color(C)} :- node(N).

% better node not assigned two colors
1{is(N,C) : color(C)}1 :- node(N).

#show is/2.
