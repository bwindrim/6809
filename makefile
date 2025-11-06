# Makefile to assemble .a files into .ex9 files using as6809

AS=as6809
SRC=boot2.a despatch.a blink3.a
INC=via6522.i globals.i
OBJ=$(SRC:.a=.ex9)

all: $(OBJ)

boot2.ex9: boot2.a via6522.i

despatch.ex9: despatch.a via6522.i globals.i

blink3.ex9: blink3.a via6522.i globals.i init.i acia6551.i despatch.i stream.i tick.i porta_out.i poll.i toolbox.i dump.i


%.ex9: %.a
	$(AS) -o $@ $<

clean:
	rm -f $(OBJ)