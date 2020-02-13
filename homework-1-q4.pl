%
p :- not q.
q :- not p.
r :- not s.
s :- not r.
-s :- q.

%s1 = { q, -s, r }
%
%p :- not q.
%q :- not p.
%r :- not s.
%s :- not r.
%-s :- q.
%
%s2 = { p, r }
%s3 = { s, p }

