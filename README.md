A small example of a calculator written with flex / bison.

Compile using the `Makefile` 

    $ make

or manually on Linux, follow this steps:

    $ bison -d calc.y
    $ flex calc.l
    $ gcc calc.tab.c lex.yy.c -o calc -lm
    $ ./calc
