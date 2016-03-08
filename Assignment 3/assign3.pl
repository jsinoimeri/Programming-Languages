% #Jeton Sinoimeri
% #100875046


% #Facts about the graph.
isa(fish, animal).
isa(bird, animal).
isa(penguin, bird).
isa(opus, penguin).
isa(ostrich, bird).
isa(canary, bird).
isa(tweety, canary).
isa(robin, bird).

hasproperty(animal, cover, skin).
hasproperty(bird, cover, feathers).
hasproperty(bird, travel, fly).
hasproperty(penguin, travel, walk).
hasproperty(penguin, colour, brown).
hasproperty(ostrich, travel, walk).
hasproperty(canary, colour, yellow).
hasproperty(tweety, colour, white).
hasproperty(robin, colour, red).
hasproperty(robin, sound, sing).
hasproperty(fish, travel, swim).





% #Part1 Finding the properties and values of each type of animal.
whatProperty(Z, Property, Value):-
   hasproperty(Z, Property, Value).

whatProperty(X, Property, Value):-
   isa(X, Y),
   whatProperty(Y, Property, Value).





% #Part 2 Union of two lists.
myunion(T, U, V):- sort(T, X), sort(U, Y), myUnion(X, Y, Z), sort(Z, V).

myUnion([],[],[]).
myUnion([],[A|B],[A|B]).
myUnion([A|B],[],[A|B]).
myUnion([A|B], C, [A|D]) :-  not(member(A, C)), myUnion(B, C, D).
myUnion([A|B], C, D) :- member(A, C), !, myUnion(B, C, D). 





% #Part 3 removing item from list.
remove_at(List, Position, Item, NewList):-
	nth1(Position, List, Item),
	delete(List, Item, NewList).