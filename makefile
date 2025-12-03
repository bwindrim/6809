# Makefile to assemble .a files into .ex9 files using as6809

AS=as6809
SRC=boot2.a despatch.a timer1.a panic.a portA.a blink5.a
INC=via6522.i globals.i panic.i
OBJ=$(SRC:.a=.ex9)

all: $(OBJ)

boot2.ex9: boot2.a via6522.i globals.i

despatch.ex9: despatch.a via6522.i globals.i

timer1.ex9: timer1.a via6522.i globals.i

panic.ex9: panic.a via6522.i globals.i

portA.ex9: portA.a via6522.i globals.i

blink5.ex9: blink5.a panic.i via6522.i globals.i acia6551.i


%.ex9: %.a
	$(AS) -o $@ $<

clean:
	rm -f $(OBJ)