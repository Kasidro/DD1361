CC = gcc
FLAGS = -W -g 

all: utfil

utfil: nod.o program.o
	$(CC) $(FLAGS) -o utfil nod.o program.o

program.o: program.c
	$(CC) $(FLAGS) -c program.c

nod.o:	nod.c nod.h
	$(CC) $(FLAGS) -c nod.c

clean:
	touch dumt.o utfil
	rm *.o utfil

