%p(a) :- not p(b).
%p(b) :- not p(c).
%p(c) :- not p(a).

%p(c).

% reduct
%
% rule 2 gets removed by step 1.
%p(a) :- not p(b).
%p(c) :- not p(a).

% Problem 1
% 1. The reduct of Π is p(a). p(c).
% 2. No, the only answer set of Π is { p(a),p(c) }.  Set S is missing p(a) which is true because we have no reason to believe p(b).

%p | q | r.
%-p :- not s.

%If we have no reason to believe in s, p is not true. (We have no reason to believe in s).

% Problem 2
%s1 = { -p, q }
%s2 = { -p, r }

% Problem 3

p(a) | -p(b).
q(X)  :- -p(X).
-q(X) :- not q(X).
r(X)  :- not p(X).
