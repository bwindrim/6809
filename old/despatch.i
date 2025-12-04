resetvec	equ	$FFFE	; hardware interrupt vectors
nmivec		equ	$FFFC
swivec		equ	$FFFA
irqvec		equ	$FFF8
firqvec		equ	$FFF6
swi2vec		equ	$FFF4
swi3vec		equ	$FFF2
unknown		equ	$FFF0	; despatcher interrupt vectors
ca2vec		equ	$FFEE
ca1vec		equ	$FFEC
srvec		equ	$FFEA
cb2vec		equ	$FFE8
cb1vec		equ	$FFE6
t2vec		equ	$FFE4
t1vec		equ	$FFE2
viabadvec	equ	$FFE0

RTDESP		macro
		  rti
		endm

		begin
		  begin
intinit:	    ldd		irqvec
		    std		unknown
		    ldd		#intdespatch
		    std		irqvec
		    jmp		init

init		    redef	intinit
		  end

intdespatch:	  ldx	#unknown
		  lda	ifr
		  sbpl	out

		  anda	ier
		  ora	#$80		; set last bit to ensure default vec

loop:		  leax	-2,x
		  asra
		  sbcc	loop

out:		  jmp	[,x]
		end
