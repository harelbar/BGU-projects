all: program

program: main.c header.h
	gcc -o OS main.c -I.

run: program
	./OS

clean:
	rm OS
