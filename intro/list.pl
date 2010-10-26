
length([H|T], N) :- length(H, N1), N is N.
length(H, N) :- N is 1.