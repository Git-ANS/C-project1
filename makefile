ABC.exe: main.o big3.o fact.o reverse.o
	gcc -o ABc.exe main.o big3.o fact.o reverse.o


main.o:main.c
	gcc -c main.c
	
	
