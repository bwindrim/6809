		begin
timeconst	  equ	20000

		  begin
intinit:	    ldd		#inthndl
		    std		t1vec
		    ldd		#timeconst
		    exg		a,b
		    std		t1cl
		    lda		acr
		    ora		#@01000000
		    sta		acr
		    lda		#enable | t1flag
		    sta		ier
		    bra		init

init		    redef	intinit
		  end
		  

count:		  db	100

inthndl:	  lda	t1cl	; clear source of interrupt
		  dec	count
		  sbne	out

		  lda	#100
		  sta	count
		  clif
		  bsr	tick
out:		  rtdesp
		end
