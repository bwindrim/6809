
portastream:	stream

		begin
		  begin
intinit:	    ldd		#portaint
		    std		ca1vec

		    lda		pcr
		    anda	#@11110000
		    ora		#@00001010
		    sta		pcr

		    lda		acr
		    ora		#@00000001
		    sta		acr

		    lda		#enable | ca1flag
		    sta		ier

		    jmp		init

init		    redef	intinit
		  end

portawake:	  begin			; incoming port wakeup routine
		    ldb	#enable | ca1flag ; call only with interrupts disabled
		    stb	ier
		    rts
		  end

portaint:				; incoming port interrupt handler
		  begin			; interrupts off for duration
		    lda		portaAlt
		    ldx		#portastream
		    ldy		#portawake
		    putcharwake
		    tstb
		    sbeq	full

		    lda		porta
		    rtdesp

full:		    lda		#disable | ca1flag
		    sta		ier
		    rtdesp
		  end
		end
