        ; Hardware interrupt vectors.
g_memtop	equ	$FFFE   ; aliased to the reset vector
g_resetvec	equ	$FFFE   ; reset vector
resetvec	equ	$FFFE   ; reset vector alias
nmivec	        equ	$FFFC   ; NMI vector alias
g_nmivec	equ	$FFFC   ; NMI vector
g_swivec	equ	$FFFA   ; SWI vector
irqvec	        equ	$FFF8   ; IRQ vector alias
g_irqvec	equ	$FFF8   ; IRQ vector
g_firqvec	equ	$FFF6   ; FIRQ vector
g_swi2vec	equ	$FFF4   ; SWI2 vector
g_swi3vec	equ	$FFF2   ; SWI3 vector

        ; Despatcher interrupt vectors.
g_unknownvec	equ	$FFF0   ; Unknown vector, i.e. not from 6522
g_ca2vec	equ	$FFEE   ; CA2 vector
ca1vec	        equ	$FFEC   ; CA1 vector alias
g_ca1vec	equ	$FFEC   ; CA1 vector
g_srvec	        equ	$FFEA   ; SR vector
g_cb2vec	equ	$FFE8   ; CB2 vector
g_cb1vec	equ	$FFE6   ; CB1 vector
g_t2vec	        equ	$FFE4   ; T2 vector
g_t1vec	        equ	$FFE2   ; T1 vector
t1vec	        equ	$FFE2   ; T1 vector alias
g_viabadvec	equ	$FFE0   ; vector for spurious 6522 interrupts

        ; Timer globals.
g_tickvec       equ	$FFDE   ; 1ms tick interrupt vector
g_ticks         equ	$FFDC   ; rolling tick counter

        ; Std IO globals.
        ; These point to subroutines that implement standard IO semantics,
        ; i.e. they take a memory address in X and a size in D. The number of
        ; bytes actually processed is returned in D.
g_stderr      equ	$FFDA   ; standard error procedure address
g_stdout      equ	$FFD8   ; standard output procedure address
g_stdin       equ	$FFD6   ; standard input procedure address
        ; General globals.
g_base          equ	$FFC0   ; base address for globals