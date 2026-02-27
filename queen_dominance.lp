% ===== Input parameters (passed via -c) =====
% n = number of queens
% i = number of rows
% j = number of columns

% domain
row(1..i).
col(1..j).

% queen placement choice rule - choosing exactly n from all possible positions (X,Y)
{ queen(X,Y) : col(X), row(Y) } = n.

% a square is attacked if:
% it is in same column, but in a different row (i.e., attacked vertically)
attacked(X,Y1):- queen(X,Y2), row(Y1), Y1!=Y2.

% it is in same row, but in a different column (i.e., attacked horizontally)
attacked(X1,Y):- queen(X2,Y), col(X1), X1!=X2.

% it is in the same diagonal (i.e., attacked diagonally)
attacked(X1,Y1):- queen(X2,Y2), col(X1), row(Y1), X1-Y1==X2-Y2, X1!=X2, Y1!=Y2.
attacked(X1,Y1):- queen(X2,Y2), col(X1), row(Y1), X1+Y1==X2+Y2, X1!=X2, Y1!=Y2.

% a square is dominated if it has a queen or it is attacked
dominated(X,Y) :- queen(X,Y).
dominated(X,Y) :- attacked(X,Y).

% global constraint - forbids models if undominated
:- col(X), row(Y), not dominated(X,Y).

% clears default output
#show.

% Output - for every true queen(X,Y), printing the term X,Y.
#show (X,Y) : queen(X,Y).
