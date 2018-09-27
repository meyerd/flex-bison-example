A small example of a calculator written with flex / bison.

If you want to run this code on **linux**, follow this steps:

* bison -d calc.y
* flex -o calc.l
* gcc * .c -o calculator -lm
* ./calculator
