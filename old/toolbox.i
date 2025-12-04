		begin
hex_nybble:	  begin
		    pshs	a,b
		    anda	#$0F
		    cmpa	#$A
		    sbhs	alpha

		    adda	#'0'
		    sbra	over

alpha:		    adda	#('A' - $A)

over:		    putchar
		    puls	a,b,pc
		  end

hex_byte	entry
		  begin
		    pshs	a
		    lsra
		    lsra
		    lsra
		    lsra
		    jsr		hex_nybble
		    puls	a
		    jsr		hex_nybble
		    rts
		  end

hex_word	entry
		  begin
		    pshs	d
		    jsr		hex_byte
		    lda		1,s
		    jsr		hex_byte
		    puls	d,pc
		  end
		end
