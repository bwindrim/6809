        ; Hardware interrupt vectors.
g_memtop	equ	$FFFE   ; aliased to the reset vector
g_resetvec	equ	$FFFE   ; reset vector
resetvec	equ	$FFFE   ; reset vector
nmivec	equ	$FFFC   ; NMI vector
g_nmivec	equ	$FFFC   ; NMI vector
g_swivec	equ	$FFFA   ; SWI vector
irqvec	equ	$FFF8   ; IRQ vector
g_irqvec	equ	$FFF8   ; IRQ vector
g_firqvec	equ	$FFF6   ; FIRQ vector
g_swi2vec	equ	$FFF4   ; SWI2 vector
g_swi3vec	equ	$FFF2   ; SWI3 vector

        ; Despatcher interrupt vectors.
g_unknownvec	equ	$FFF0   ; Unknown vector, i.e. not from 6522
g_ca2vec	equ	$FFEE   ; CA2 vector
ca1vec	equ	$FFEC   ; CA1 vector
g_ca1vec	equ	$FFEC   ; CA1 vector
g_srvec	        equ	$FFEA   ; SR vector
g_cb2vec	equ	$FFE8   ; CB2 vector
g_cb1vec	equ	$FFE6   ; CB1 vector
g_t2vec	        equ	$FFE4   ; T2 vector
g_t1vec	        equ	$FFE2   ; T1 vector
t1vec	        equ	$FFE2   ; T1 vector
g_viabadvec	equ	$FFE0   ; vector for spurious 6522 interrupts
