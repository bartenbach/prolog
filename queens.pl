% N-Queens problem solution in ASP
row(1..8).
col(1..8).

% choice rule
% set creation, generate exactly 8 facts of this particular form
8 {queen(I,J) : col(I), row(J)} 8.

% Cannot have two queens in the same row
:- queen(I,J), queen(I,JJ), J != JJ.

% Cannot have two queens in the same column
:- queen(I,J), queen(II,J), I != II.

% Cannot have two queens on the same diagonal by comparing slopes
:- queen(I,J), queen(II,JJ),
  (I,J) != (II,JJ), 
  |I - II| = |J - JJ|.
