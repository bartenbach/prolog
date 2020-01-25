% test
p(a) | -p(b).
q(a) :- -p(a).
q(b) :- -p(b).
-q(a) :- not q(a).
-q(b) :- not q(b).
r(a) :- not p(a).
r(b) :- not p(b).

% s1 = { p(a), -q(a), -q(b),  r(b) }
% s2 = { -p(b), -q(a), q(b), r(a), r(b) }
