% =========================================================
% ARTI 303 - Programming for AI
% Lab 5 - Working with Rules
% Task 1 - Family Knowledge Base
% =========================================================


% ---------------------------------------------------------
% Gender Facts
% ---------------------------------------------------------

male(abraham).
male(clancy).
male(herb).
male(homer).
male(bart).
male(brace).

female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).
female(ling).


% ---------------------------------------------------------
% Parent Facts
% ---------------------------------------------------------

parent(abraham, herb).
parent(abraham, homer).
parent(mona, homer).

parent(clancy, marge).
parent(clancy, patty).
parent(clancy, selma).

parent(jackie, marge).
parent(jackie, patty).
parent(jackie, selma).

parent(homer, bart).
parent(homer, lisa).
parent(homer, maggie).

parent(marge, bart).
parent(marge, lisa).
parent(marge, maggie).

parent(selma, ling).


% ---------------------------------------------------------
% Rules
% ---------------------------------------------------------


% Father
% X is the father of Y if X is a parent of Y and X is male.

father(X, Y) :-
    parent(X, Y),
    male(X).


% Mother
% X is the mother of Y if X is a parent of Y and X is female.

mother(X, Y) :-
    parent(X, Y),
    female(X).


% Son
% X is the son of Y if Y is a parent of X and X is male.

son(X, Y) :-
    parent(Y, X),
    male(X).


% Daughter
% X is the daughter of Y if Y is a parent of X and X is female.

daughter(X, Y) :-
    parent(Y, X),
    female(X).


% Brother
% X is the brother of Y if they share a parent,
% X is male, and X and Y are different people.

brother(X, Y) :-
    parent(P, X),
    parent(P, Y),
    male(X),
    X \= Y.


% Sister
% X is the sister of Y if they share a parent,
% X is female, and X and Y are different people.

sister(X, Y) :-
    parent(P, X),
    parent(P, Y),
    female(X),
    X \= Y.


% Grandfather
% X is the grandfather of Z if X is male,
% X is a parent of Y, and Y is a parent of Z.

grandfather(X, Z) :-
    parent(X, Y),
    parent(Y, Z),
    male(X).


% Aunt
% X is the aunt of Y if X is female and X is
% a sister of one of Y's parents.

aunt(X, Y) :-
    sister(X, P),
    parent(P, Y).


% Uncle
% X is the uncle of Y if X is male and X is
% a brother of one of Y's parents.

uncle(X, Y) :-
    brother(X, P),
    parent(P, Y).


% Cousin
% X and Y are cousins if their parents are siblings
% and X and Y are different people.

cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    P1 \= P2,
    (brother(P1, P2) ; sister(P1, P2)),
    X \= Y.


% Ancestor - Base Case
% X is an ancestor of Y if X is directly a parent of Y.

ancestor(X, Y) :-
    parent(X, Y).


% Ancestor - Recursive Case
% X is an ancestor of Y if X is a parent of Z
% and Z is an ancestor of Y.

ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).