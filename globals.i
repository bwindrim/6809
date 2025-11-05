        ; Hardware interrupt vectors.
resetvec	equ	$FFFE       ; reset vector
nmivec		equ	$FFFC       ; NMI vector
swivec		equ	$FFFA       ; SWI vector
irqvec		equ	$FFF8       ; IRQ vector
firqvec		equ	$FFF6       ; FIRQ vector
swi2vec		equ	$FFF4       ; SWI2 vector
swi3vec		equ	$FFF2       ; SWI3 vector

        ; Despatcher interrupt vectors.
unknownvec	equ	$FFF0       ; Unknown vector, i.e. not from 6522
ca2vec		equ	$FFEE       ; CA2 vector
ca1vec		equ	$FFEC       ; CA1 vector
srvec		equ	$FFEA       ; SR vector
cb2vec		equ	$FFE8       ; CB2 vector
cb1vec		equ	$FFE6       ; CB1 vector
t2vec		equ	$FFE4       ; T2 vector
t1vec		equ	$FFE2       ; T1 vector
viabadvec	equ	$FFE0       ; vector for spurious 6522 interrupts
