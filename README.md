Tate Prodigalidad
CMSC 430
Project2 Documentation

1.	Approach
To implement the required changes for Project 2, I followed a phased approach and verified each phase with the provided test data. For every test, I rebuilt the project and executed a consistent run procedure:
make
cp "<TESTDIR>/testN.txt" input.txt
./compile
cat listing.txt
I started by confirming the baseline pipeline and driver. After ensuring make produced the compile binary and that listing.txt was generated from input.txt, I validated the initial program shape with test1.txt (arithmetic expression in a minimal function). This confirmed scanner/parser wiring, token handoff, and listing output.
Next, I extended the grammar to cover simple statements beyond expressions. I added the WHEN statement and validated with test2.txt. I then introduced SWITCH/CASE/OTHERS with a single expression body, verified by test3.txt. With control-flow in place, I added list declarations and indexing, and ran test4.txt.
With structure working, I expanded literal and type coverage. I added real literals and character literals, and validated with test5.txt. These changes also required updating the scanner’s numeric/char rules and corresponding tokens.
I then implemented the IF / ELSIF* / ELSE** family. Because Bison does not support EBNF braces directly, I replaced “zero or more” ELSIFs with a recursive elsif_tail production and validated the full statement with test6.txt.
Next, I implemented the FOLD statement and its two subordinate productions: direction (left/right) and operator (add/mul). I accepted either an identifier or a list literal as the fold target and verified with test7.txt.
I broadened declaration forms to permit 0 or more variable declarations (replacing the skeleton’s 0 or 1 behavior with a recursive list) and validated using test8.txt. After that, I enabled 0 or more function parameters in the header using a comma-separated list and confirmed both the single-parameter case with test9.txt and the two-parameter case with test10.txt.
I finished the arithmetic operator set by adding remainder (%), exponentiation (^) (right-associative), and unary minus (~) with the correct precedence layering. I verified all operator interactions with test11.txt. Then I added the remaining logical operators | (lowest precedence) and ! (highest), and validated the combined relational/logical precedence with test12.txt.
With the full language in place, I confirmed that nested constructs parse correctly by running test13.txt (nested if) and test14.txt (nested switch). These tests ensured that statement lists, control-flow scoping, and designator recursion behaved as expected under composition.
Finally, I implemented targeted error recovery so that the compiler reports meaningful diagnostics and continues parsing where appropriate. I added a recovery in the function header (missing colon in a parameter), validated with syntax2.txt; a recovery in variable declarations, validated with syntax3.txt; a guarded case-body rule plus a switch-tail that reports a missing OTHERS, validated with syntax4.txt; and combined all recoveries in syntax5.txt, confirming that the compiler reports the expected five errors. Throughout, I kept a generic recovery at the statement-list level (not at the individual statement when it would swallow switch-tail errors) and normalized messages via yyerror so listing output remained concise.
Operationally, I worked in WSL with inputs stored under /mnt/c/.... I quoted paths containing spaces and normalized CRLF endings in scripts and tests as needed. For bulk validation, I used a simple loop over tests 1–14 and syntax1–5 that rebuilt once, copied each case to input.txt, ran ./compile, and aggregated all listing.txt outputs for quick review.

2.	Test Plan
Each test was used to validate a specific portion of the lexical analyzer / parser pipeline. The tables below summarize the objectives and results.
Test Case	Description	Expected Result	Screenshot (paste here)
test1.txt	Arithmetic expression (baseline)	Compile successfully	 
test2.txt	WHEN statement	Compile successfully	 
test3.txt	SWITCH/CASE with OTHERS	Compile successfully	 
test4.txt	List variable declaration + indexing	Compile successfully	 
test5.txt	Real & character literals/variables	Compile successfully	 
test6.txt	IF with multiple ELSIF + ELSE	Compile successfully	 
test7.txt	FOLD left/right + operator	Compile successfully	 
test8.txt	Multiple variable declarations (0+)	Compile successfully	 
test9.txt	Single parameter declaration	Compile successfully	 
test10.txt	Two parameter declarations	Compile successfully	 
test11.txt	All arithmetic operators	Compile successfully	 
test12.txt	Relational and logical operators	Compile successfully	 
test13.txt	Nested IF (comprehensive)	Compile successfully	 
test14.txt	Nested SWITCH (comprehensive)	Compile successfully	 
 
Test Case	What it tests	Expected Result	Screenshot (paste here)
syntax1.txt	Expression error (missing operator)	1 syntax error; recovered at ';'	 
syntax2.txt	Function header param colon recovery	1 syntax error; rest parses	 
syntax3.txt	Variable declaration error recovery	1 syntax error; no cascade	 
syntax4.txt	Bad CASE body + missing OTHERS	2 syntax errors	 
syntax5.txt	Multiple errors incl. missing OTHERS	5 syntax errors	 


3.	Lessons Learned
This project clarified how to turn a language spec into a working Bison grammar. I replaced the spec’s EBNF zero-or-more notation with explicit recursive lists for parameters, variables, and ELSIF chains, which made the grammar easier to maintain and gave me clear places to add recovery. I also layered expressions so precedence and associativity were unambiguous; making exponentiation right-recursive and keeping unary above the binary tiers removed several early conflicts.
Conflict debugging was mostly about running Bison with -v and reading the .output file. The counterexample hints helped me tighten the designator rule and separate expression tiers more cleanly. I also avoided tool collisions by renaming tokens that overlap with Flex macros (e.g., using BEGIN_ instead of BEGIN).
Error recovery needed careful placement. A broad statement: error ';' rule is convenient, but it can hide switch-tail errors, including the “missing OTHERS” case. Moving the generic recovery to the statement list and adding targeted rules (CASE INT_LITERAL ARROW error ';' and switch alternatives that accept malformed bodies) produced the expected messages without duplication. I also removed extra appendError(...) calls where the error token already reports an issue.
On the tooling side, I normalized CRLF endings and quoted /mnt/c/... paths in WSL to avoid noisy failures unrelated to the grammar. I kept a simple shell loop to rebuild once and run the whole suite (tests 1–14 and syntax1–5) after each change. That made it straightforward to confirm the specific expectations: two errors on syntax4 and five on syntax5.
