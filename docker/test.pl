# swipl -s test.pl -g go -g halt

child_of(joe, ralf).
child_of(mary, joe).
child_of(steve, joe).
descendent_of(X, Y) :-
    child_of(X, Y).
descendent_of(X, Y) :-
    child_of(Z, Y),
    descendent_of(X, Z).

go :- forall(descendent_of(steve, X), writeln(X)).
