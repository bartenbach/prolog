% Three color map problem
color(green ; blue; red).
node(a;b;c;d;e;f;g).

edge(a,f).
edge(f,g).
edge(f,c).
edge(h,b).
edge(b,c).
edge(c,d).
edge(b,e).
edge(d,e).

edge(X,Y) :- edge(Y,X).

%is(n, red) | is(n, green) | is(n, blue) :- node(n).
% I really messed this one up.  This is nuts.
1{is(C,N) : color(C)} :- node(N).
% choice rule looks really useful for generating combinations of facts

adjacent(X,Y) :- edge(X,Y), X != Y.

:- is(N1,C), is(N2,C), adjacent(N1,N2).                 

