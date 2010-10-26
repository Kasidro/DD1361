history(
b(
  l(yeast),
  b(
    b(
      l(fly),
      l(mosquito)
     ),
    b(
      l(frog),
      b(
	l(chicken),
	b(
	  l(mouse),
	  b(
	    l(human),
	    l(chimp)
	   )
	 )
       )
     )
   )
 )).

tree1(l(enkelt)).
tree2(b(l(1),l(2))).
tree3(b(l(1),b(l(2),l(3)))).
tree4(b(b(l(1),l(2)), b(l(3), l(4)))).
tree5(b(l(1), b(l(2), b(l(3),b(l(4),l(5)))))).
tree6(b(b(l(1), b(l(2), b(l(3),b(l(4), l(5))))),
	b(l(6), b(l(7), b(l(8),b(l(9), l(10))))))).


writetree(T) :- writetree(T, 0).
writetree(l(X), N) :- indent(N), write(X).
writetree(b(X,Y), N) :-
	indent(N),
	write('('), nl,
	Next is N + 2,
	writetree(X, Next),
	write(', '), nl,
	writetree(Y, Next), nl,
	indent(N),
	write(')').

indent(0).
indent(N) :- N>0, write(' '), Next is N-1, indent(Next).



%
% count_leaves/2
%
count_leaves(b(X, Y), N) :- count_leaves(X, N1),
                            count_leaves(Y, N2), N is N1 + N2.

count_leaves(l(_), N) :- N is 1.

%
% Leaves/2
%
leaves(b(X, Y), Leaf) :-  leaves(X, XLeaf),
                          leaves(Y, YLeaf),
                          append(XLeaf, YLeaf, Leaf).

leaves(l(X), Leaf) :- Leaf = [X].


%
% build_tree/2
%
build_tree([H|T], Tr) :-  B1 = l(H),
                          build_tree(T, B2),
                          Tr = b(B1, B2).

build_tree([H|[]], Tr) :- Tr = l(H).


%
% height/2
%
height(b(X, Y), H) :- height(X, H1),
                      height(Y, H2),
                      max(H1, H2, M),
                      H is M + 1.

height(l(_), 1).

max(A, B, A) :- A >= B.
max(A, B, B) :- B > A.

%
% balanced/1
%
balanced(b(X, Y)) :-  height(X, HX),
                      height(Y, HY),
                      isBalanced(HX, HY),
                      balanced(X),
                      balanced(Y).

balanced(l(_)).

isBalanced(X, Y) :- (X + 1) =:= Y.
isBalanced(X, Y) :- X =:= Y.
isBalanced(X, Y) :- X =:= (Y + 1).
