
solve_crossword(L, C) :- 
              C = [ W1,
                    W2,
                    W3,
                    W4,
                    W5,
                    W6],
              
              W1 = [C11, _, C13, _, C15],
              W2 = [C31, _, C33, _, C35],
              W3 = [C51, _, C53, _, C55],
              
              W4 = [C11, _, C31, _, C51],
              W5 = [C13, _, C33, _, C53],
              W6 = [C15, _, C35, _, C55],
              
              find(L, W1),
              find(L, W2),
              find(L, W3),
              find(L, W4),
              find(L, W5),
              find(L, W6).


find([H|T], C) :-
              H = C; find(T, C).


write_crossword([W1, W2, W3, [_, C42, _, C44, _], [_, C52, _, C54, _], [_, C62, _, C64, _]]) :-
              format(W1, []),
              nl,
              format([C42, 32, C52, 32, C62], []),
              nl,
              format(W2, []),
              nl,
              format([C44, 32, C54, 32, C64], []),
              nl,
              format(W3, []).


weight(69, 1).  % E
weight(65, 1).  % A
weight(73, 1).  % I
weight(79, 1).  % O
weight(78, 1).  % N
weight(82, 1).  % R
weight(84, 1).  % T
weight(76, 1).  % L
weight(83, 1).  % S
weight(85, 1).  % U

weight(68, 2).  % D
weight(71, 2).  % G

weight(66, 3).  % B
weight(67, 3).  % C
weight(77, 3).  % M
weight(80, 4).  % P

weight(70, 4).  % F
weight(72, 4).  % H
weight(86, 4).  % V
weight(87, 4).  % W
weight(89, 4).  % Y

weight(75, 5).  % K

weight(74, 8).  % J
weight(88, 8).  % X

weight(81, 9).  % Q
weight(90, 9).  % Z


word_weight([H|T], Weight) :-
              word_weight(T, W1),
              weight(H, W2),
              Weight is W1 + W2.

word_weight([], Weight) :-
              Weight = 0.


require_min_weight([H|T], MinWeight, WordsAboveWeight) :-
              word_weight(H, Weight),
              Weight >= MinWeight,
              !,
              require_min_weight(T, MinWeight, W1),
              append([H], W1, W2),
              WordsAboveWeight = W2.

require_min_weight([_|T], MinWeight, WordsAboveWeight) :-
              require_min_weight(T, MinWeight, WordsAboveWeight).

require_min_weight([], MinWeight, WordsAboveWeight) :-
              WordsAboveWeight = [].

better_crossword(MinWeight, C) :-
              words(L),
              require_min_weight(L, MinWeight, WordsAboveWeight),
              solve_crossword(WordsAboveWeight, C).
