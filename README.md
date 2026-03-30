# Chess_Queen_Domination_Solver_ASP

**Introduction:**

A chess queen domination solver answers whether it is possible to place n queens on an i x j board (rectangular chessboard with i rows and j columns) such that all squares are attacked or have a queen on them. It is written with Answer Set Programming (ASP) using the platforms like Clingo or ASPChef (https://asp-chef.alviano.net/).

**Choosing the methods:**

ASP is chosen to write this queen domination solver, because it feels more natural when we think in logical rules. It is specifically designed to model and solve such problems elegantly and compactly. There are few other considerations on why ASP is chosen, e.g.,

    o	In ASP, rules like “exactly N queens”, “no square undominated”, “diagonal attack” are expressed directly as logical constraints, making the encoding intuitive and compact. 

    o	The other aspect is scalability and efficiency. Modern ASP solvers use advanced SAT-solving techniques internally, making them very efficient for large combinatorial problems.


**Problem Description:**
The problem models the Queen Domination problem on a rectangular chessboard.
  
  o	Given:
  
      o	A fixed number of queens.
      
      o	A specified number of rows and columns.
      
  o	The goal is to determine placements such that:
  
      o	Every square is either occupied by a queen or attacked by at least one queen.

<img width="700" height="205" alt="image" src="https://github.com/user-attachments/assets/cfc8e803-298f-4c79-9624-18c85fbcd9d2" />

**Design:**

    o	The system is designed using a declarative modelling approach.
    
    o	The board is represented as a grid defined by row and column domains.
    
    o	Queen placement is handled via a choice rule with exact cardinality.
    
    o	Attack relations (horizontal, vertical, diagonal) are modelled using logical rules.
    
    o	Domination is derived from queen placement and attack rules.
    
    o	A global integrity constraint is included which ensures that no square remains undominated.
    
    o	The model separates the input parameters, logical rules, output specification.
    
**Domain:**

o	The domain consists of:

    •	Rows (row/1)

    •	Columns (col/1)

    •	Board positions ((X,Y) pairs)

o	Input values are provided as:

    •	n/1

    •	i/1

    •	j/1

o	The Cartesian product of rows and columns defines all valid board coordinates.

o	All predicates are safely grounded to ensure correctness and solver efficiency.


**Constraints:**

o	Cardinality constraint:

    •	Exactly N queens must be placed.

o	Attack rules:

    •	Same row
    
    •	Same column
    
    •	Same diagonal

o	Domination rule:

    •	A square is dominated if:

        •	It contains a queen, or

        •	It is attacked.

o	Global constraint:

    •	No undominated square is allowed.


**Implementation:**
The input values are:

% n = number of queens

% i = number of rows

% j = number of columns

Line 7 and 8:  creates the board with rows from 1 to i and columns from 1 to j. i and j are inputs.

Line 11: is a choice rule for queen placement, which means:

    o	From all possible board positions (X,Y),

    o	Exactly n is chosen,

    o	And made queen(X,Y) true for those.

The next section defines the attack rules:

Line 15: a square (X, Y1) is attacked if there is a queen in the same column X, but at some other row Y2. Y1!=Y2 indicates that it is not the queen’s own square. That means this rule says, all other squares in the same column are attacked vertically. Y1 is bound to row(Y1), meaning Y1 will be tried with all possible values of the defined row. This is called grounding.

Line 18: a square (X1, Y) is attacked if there is a queen in the same row Y, but at some other column X2. X1!=X2 indicates that it is not the queen’s own square. That means this rule says, all other squares in the same row are attacked horizontally. In this case, X1 is bound to col(X1).

Line 21, 22: defines the diagonal attack rules. A square (X1, Y1) is attacked if there is a queen in a different square which is not diagonal (absolute difference in columns equals absolute difference in rows) to that square (X1, Y1). Those two rules are for two diagonal directions:

    o	X1 – Y1 = X2 - Y2, this is for one diagonal direction

    o	X1 + Y1 = X2 + Y2, and this one for the other direction

Together they cover all diagonals.

The next section defines the rule for a dominated square:

Line 25, 26:  A square (X, Y) is dominated if it has a queen in the same square, or it is attacked (vertically/horizontally/diagonally)

The below is a global constraint: 

Line 29: It says, it is forbidden that there exists any square (X, Y) which is not dominated. That means, if even one square is uncovered, the answer set is rejected. This forces full board domination.


**Testing:**

Testing  is done via Clingo package (via command line in Windows 11 system). Below are the test results seen:

Setup: 

    i.	Downloaded the Clingo Package from the link (https://sourceforge.net/projects/potassco/files/clingo) given in official website (https://potassco.org/clingo/)
    
    ii.	Local Path: Unzipped and kept in “C:\clingo\clingo-4.5.4-win64” locally.


Run command:

Ran the below command in “Command Prompt” (hint: admin privilege is not necessary):

    clingo queen_dominance.lp -c n=2 -c i=4 -c j=5 0

where the command-line parameters:

    n = 2 = number of queens

    i = 4 = number of rows

    j = 5 = number of columns

    0 = show all models = number of models to be shown

Results:

<img width="940" height="431" alt="image" src="https://github.com/user-attachments/assets/60b045e9-465b-4e07-9d3b-4b4f8f09c6fc" />

(few more results with different inputs):

    clingo queen_dominance.lp -c n=3 -c i=4 -c j=5 0

<img width="917" height="300" alt="image" src="https://github.com/user-attachments/assets/a98f9194-e741-494d-9f09-c349cb3f1e5d" />

<img width="917" height="197" alt="image" src="https://github.com/user-attachments/assets/61f029ff-d4cc-4b44-bb36-ae11b9b84e9b" />

    clingo queen_dominance.lp -c n=3 -c i=7 -c j=8 0

<img width="917" height="309" alt="image" src="https://github.com/user-attachments/assets/949b21e6-7087-416c-8829-eab757e2c0df" />

    clingo queen_dominance.lp -c n=3 -c i=5 -c j=6 0

<img width="912" height="177" alt="image" src="https://github.com/user-attachments/assets/a74370f5-7967-45fe-a53f-2b184e6a1d4d" />

<img width="916" height="180" alt="image" src="https://github.com/user-attachments/assets/23fc5107-db0d-4ffc-8512-2c2e2848581a" />


**Requirements for compiling and running the code on a fresh installation of Ubuntu 24.04 system:**

    A)	System Requirements:

        Fresh installation of Ubuntu 24.04 (fresh install) already includes bash, apt. Only Clingo needs to be installed.

    B)	Installation of Clingo:

        sudo apt update
        
        sudo apt install clingo
        
        can be verified using:
        
        clingo --version

    C)	No Compilation Needed:
    
        ASP programs (.lp files) do not require compilation. They are interpreted directly by Clingo.
    
    D)	Running the program: (Open Terminal using Ctrl+Alt+T)
    
        clingo queen_dominance.lp -c n=2 -c i=4 -c j=5 0
    
        where:
        
        n = 2 = number of queens
        
        i = 4 = number of rows
        
        j = 5 = number of columns
        
        0 = show all models = number of models to be shown
 
      Inputs can also be passed as a separate .lp file e.g., inputs.lp with:
      
      numqueens(2).
      
      numrows(4).
      
      numcols(5).
      
      Then the command will be: clingo queen_dominance.lp inputs.lp 0
      
      Note: variables n,i,j are used with meaningful names: numqueens, numrows, numcols respectively. Code needs to be adapted accordingly to use these variables.










