portastream:	stream

		begin
		  begin
intinit:	    ldd		#portaint
		    std		ca1vec

		    lda		pcr
		    anda	#@11110000
		    ora		#@00001000 ; port A handshake mode
		    sta		pcr

		    lda		#enable | ca1flag
		    sta		ier

		    jmp		init

init		    redef		intinit
		  end

portawake:	  begin			; outgoing port wakeup routine
;		    jsr	wake_mess
		    ldb	#enable | ca1flag ; call only with interrupts disabled
		    stb	ier
;		    lda		#'W'
;		    sta		porta
		    rts
		  end

portaint:				; outgoing port interrupt handler
		  begin			; interrupts off for duration
		    ldx		#portastream
		    ldy		#portawake
		    getcharwake
		    tstb
		    sbeq	empty

		    sta		porta
		    rtdesp

empty:		    lda		#disable | ca1flag
		    sta		ier
;		    lda		#'S'
;		    sta		porta
;		    jsr		sleep_mess
		    rtdesp
		  end
		end

		begin
message:	  db	"wakeup", 13, 10, 0

wake_mess	entry
		  ldx	#message
		  jsr	outstring
		end

		begin
message:	  db	"sleeping", 13, 10, 0

sleep_mess	entry
		  ldx	#message
		  jsr	outstring
		end

