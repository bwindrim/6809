portbstream:	stream

		begin
		  begin
intinit:	    ldd		#portbint
		    std		cb1vec

		    lda		pcr
		    anda	#@00001111
		    ora		#@10000000 ; port B handshake mode
		    sta		pcr

		    lda		#enable | cb1flag
		    sta		ier

		    jmp		init

init		    redef		intinit
		  end

portbwake:	  begin			; outgoing port wakeup routine
;		    jsr	wake_mess
		    ldb	#enable | cb1flag ; call only with interrupts disabled
		    stb	ier
;		    lda		#'W'
;		    sta		portb
		    rts
		  end

portbint:				; outgoing port interrupt handler
		  begin			; interrupts off for duration
		    ldx		#portbstream
		    ldy		#portbwake
		    getcharwake
		    tstb
		    sbeq	empty

		    sta		portb
		    rtdesp

empty:		    lda		#disable | cb1flag
		    sta		ier
;		    lda		#'S'
;		    sta		portb
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

