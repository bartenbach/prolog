%
position(1..5).
color(red; green; yellow ; blue; white).
nationality(british; swedish; danish; norwegian; german).
drink(tea; coffee; milk; beer; water).
cigar(pallmall; blends; bluemaster; prince; dunhill).
pet(dogs; birds; cats; horses; fish).

% fluents
fluent(has_pet(P,N)) :- pet(P), nationality(N).
fluent(drinks(D,N)) :- drink(D), nationality(N).
fluent(lives_in(C,N)) :- color(C), nationality(N).
fluent(color_position(P,C)) :- position(P), color(C).
fluent(has_position(P,N)) :- position(P), nationality(N).
fluent(has_color(C,N)) :- color(C), nationality(N).
fluent(smokes(C,N)) :- cigar(C), nationality(N).

% generation
1{has_position(P,N) : position(P)} :- nationality(N).
1{has_position(P,N) : nationality(N)} :- position(P).
1{color_position(P,C) : position(P)} :- color(C).
1{color_position(P,C) : color(C)} :- position(P).
1{has_pet(P,N) : pet(P)}1 :- nationality(N).
1{has_pet(P,N) : nationality(N)}1 :- pet(P).
1{drinks(D,N) : drink(D)}1 :- nationality(N).
1{drinks(D,N) : nationality(N)}1 :- drink(D).
1{has_color(C,N) : color(C)}1 :- nationality(N).
1{has_color(C,N) : nationality(N)}1 :- color(C).
1{smokes(C,N) : cigar(C)}1 :- nationality(N).
1{smokes(C,N) : nationality(N)}1 :- cigar(C).

% it is not possible for a nationality to have more than one position
:- has_position(P1,N), has_position(P2,N), 
  position(P1), position(P2),
  nationality(N),
  P1 != P2.

% it is not possible for a color to be at multiple positions
:- color_position(P1, C), color_position(P2, C),
  position(P1), position(P2), color(C),
  P1 != P2.

% positional rules
% P1 is right of P2
right_of(P1,P2) :- P2 + 1 = P1,
  position(P1), position(P2),
  P1 != P2.
% P1 is left of P2
left_of(P1,P2) :- right_of(P2,P1),
  position(P1), position(P2),
  P1 != P2.
next_to(P1,P2) :- left_of(P1,P2); right_of(P1,P2),
  position(P1), position(P2),
  P1 != P2.

next_to(N1,N2) :- 
  has_position(P1,N1), has_position(P1+1, N2);
  has_position(P1,N1), has_position(P1-1, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2),
  N1 != N2,
  P1 != P2.
%next_to(P1,P2) :- right_of(P1,P2), 
%  position(P1), position(P2),
%  P1 != P2.

% since the green house is on the left of the white house,
% it is impossible for the white house to be the first house
% and it is impossible for the green house to be the last house
:- color_position(1, white).
:- color_position(5, green).

% the green house is on the left of the white house
color_position(P, green) :- color_position(P+1, white),
  position(P).

% if the norwegian lives in the first house, it cannot be 
% the white house because the white house cannot be in 
% position 1
:- has_color(white, norwegian).

% hints
has_pet(dogs, swedish).
drinks(tea, danish).
has_color(red, british).
drinks(coffee, N) :- has_color(green, N), nationality(N).
has_pet(birds, N) :- smokes(pallmall, N), nationality(N).
smokes(dunhill, N) :- has_color(yellow, N), nationality(N).
drinks(milk, N) :- has_position(3, N), nationality(N).
has_position(1, norwegian).
drinks(beer, N) :- smokes(bluemaster, N), nationality(N). 
smokes(prince,german).

% this is literally the only possible way this is working
% hours were wasted.
:- smokes(blends, N), has_pet(cats, N), nationality(N).
:- smokes(blends, N1), has_pet(cats, N2),
  has_position(P1, N1), has_position(P1+2, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), has_pet(cats, N2),
  has_position(P1, N1), has_position(P1+3, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), has_pet(cats, N2),
  has_position(P1, N1), has_position(P1+4, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), has_pet(cats, N2),
  has_position(P1, N1), has_position(P1-2, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), has_pet(cats, N2),
  has_position(P1, N1), has_position(P1-3, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), has_pet(cats, N2),
  has_position(P1, N1), has_position(P1-4, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).

% again, there has to be a way to do this more easily but i 
% absolutely can't figure out how
:- smokes(dunhill, N), has_pet(horses, N), nationality(N).
:- smokes(dunhill, N1), has_pet(horses, N2),
  has_position(P1, N1), has_position(P1+2, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(dunhill, N1), has_pet(horses, N2),
  has_position(P1, N1), has_position(P1+3, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(dunhill, N1), has_pet(horses, N2),
  has_position(P1, N1), has_position(P1+4, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(dunhill, N1), has_pet(horses, N2),
  has_position(P1, N1), has_position(P1-2, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(dunhill, N1), has_pet(horses, N2),
  has_position(P1, N1), has_position(P1-3, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(dunhill, N1), has_pet(horses, N2),
  has_position(P1, N1), has_position(P1-4, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).

% again, there has to be a way to do this more easily but i 
% absolutely can't figure out how
:- smokes(blends, N), drinks(water, N), nationality(N).
:- smokes(blends, N1), drinks(water, N2),
  has_position(P1, N1), has_position(P1+2, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), drinks(water, N2),
  has_position(P1, N1), has_position(P1+3, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), drinks(water, N2),
  has_position(P1, N1), has_position(P1+4, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), drinks(water, N2),
  has_position(P1, N1), has_position(P1-2, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), drinks(water, N2),
  has_position(P1, N1), has_position(P1-3, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).
:- smokes(blends, N1), drinks(water, N2),
  has_position(P1, N1), has_position(P1-4, N2),
  position(P1), position(P2),
  nationality(N1), nationality(N2).

% because the norwegian lives in the first house,
% and rule 14 stipulates that the norwegian lives next to 
% the blue house, the blue house must be house #2.
has_color(blue, N) :- has_position(2,N), nationality(N).

has_color(green, N1) :- has_position(P1,N1),
  has_color(white,N2), has_position(P1+1,N2),
  position(P1), nationality(N1), nationality(N2),
  N1 != N2.

% solver directives
#show has_pet/2.
%#show smokes/2.
%#show has_position/2.
%#show drinks/2.
%#show has_color/2.
%#show color_position/2.

% rules verified working: 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

