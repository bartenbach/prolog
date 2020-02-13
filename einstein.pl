%
position(1..5).
color(red; green; yellow ; blue; white).
nationality(british; swedish; danish; norwegian; german).
drink(tea; coffee; milk; beer; water).
cigar(pallmall; blends; bluemaster; prince; dunhill).
pet(dogs; birds; cats; horses; fish).

1{has_position(P,N) : position(P)} :- nationality(N).
1{has_position(P,N) : nationality(N)} :- position(P).
1{has_pet(P,N) : pet(P)}1 :- nationality(N).
1{has_pet(P,N) : nationality(N)}1 :- pet(P).
1{drinks(D,N) : drink(D)}1 :- nationality(N).
1{drinks(D,N) : nationality(N)}1 :- drink(D).
1{has_color(C,N) : color(C)}1 :- nationality(N).
1{has_color(C,N) : nationality(N)}1 :- color(C).
1{smokes(C,N) : cigar(C)}1 :- nationality(N).
1{smokes(C,N) : nationality(N)}1 :- cigar(C).

right_of(P1,P2) :- P2 = P1 + 1, position(P1), position(P2), P1 != P2.
left_of(P1,P2) :- right_of(P2,P1), P1 != P2.
next_to(P1,P2) :- left_of(P1,P2), P1 != P2.
next_to(P1,P2) :- right_of(P1,P2), P1 != P2.

%has_pet(P) :- pet(P), nationality(N).
has_pet(dogs, swedish).

%drinks(D) :- drink(D), nationality(N).
drinks(tea, danish).

%lives_in(C) :- color(C), nationality(N).
has_color(red, british).

%house_drinks(D, C) :- drink(D), color(C).
house_drinks(coffee, green).

left_of(green, white).

has_pet(birds, N) :- smokes(pallmall, N), nationality(N).
smokes(dunhill, N) :- has_color(yellow, N), nationality(N).
drinks(milk, N) :- has_position(3, N), nationality(N).
has_position(1, norwegian).
drinks(beer, N) :- smokes(bluemaster, N), nationality(N). 
smokes(prince,german).

% TODO rule 10 the man who smokes blends lives next to the one who keeps cats
next_to(N1,N2) :- smokes(blends, N1), has_pet(cats, N2),
  position(P1), position(P2), P1 != P2.
% TODO rule 11 the man who keeps horses lives next to the man who smokes dunhill
next_to(N1,N2) :- has_pet(horses, N1), smokes(dunhill, N2),
  nationality(N1), nationality(N2), N1 != N2.
% TODO rule 14 the norwegian lives next to the blue house
next_to(N1,N2) :- color(blue), nationality(norwegian),
  nationality(N1), nationality(N2), N1 != N2.
% TODO rule 15 the man who smokes blends has a neighbor who drinks water
next_to(N1,N2) :- smokes(blends, N1), drinks(water, N2),
  nationality(N1), nationality(N2), N1 != N2.
% solver directives
%#show has_pet/2.
%#show smokes/2.
