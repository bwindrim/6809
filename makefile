# Makefile to assemble .a files into .ex9 files using as6809

AS=as6809
SRC=boot2.a despatch.a
INC=via6522.i globals.i
OBJ=$(SRC:.a=.ex9)

all: $(OBJ)

boot2.ex9: boot2.a via6522.i

despatch.ex9: despatch.a via6522.i globals.i

%.ex9: %.a
	$(AS) -o $@ $<

clean:
	rm -f $(OBJ)