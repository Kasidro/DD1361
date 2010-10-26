
man(pelle).
man(mats).
man(lars).
man(bjorn).
man(andreas).
man(hasse).

woman(siv).
woman(susanne).
woman(cecilia).
woman(monica).


parent(pelle, bjorn).
parent(pelle, mats).
parent(pelle, lars).
parent(siv, bjorn).
parent(siv, mats).
parent(siv, lars).

parent(hasse, susanne).
parent(monica, susanne).

parent(bjorn, andreas).
parent(bjorn, cecilia).
parent(susanne, andreas).
parent(susanne, cecilia).


father(Father, Person) :- parent(Father, Person), man(Father).
mother(Mother, Person) :- parent(Mother, Person), woman(Mother).
