		begin
		  begin
intinit:	    sta		acia_reset
		    lda		#dtr | rx_int_disable | tx_disable_rts | parity_check | parity_odd
		    sta		acia_command
		    lda		#rx_clock | word_8_bits | stop_1_bits | baud_9600
		    sta		acia_control
		    ldd		#inthndl
		    std		irqvec
		    jmp		init

init		    redef	intinit
		  end

inthndl:	  lda		acia_status
		  rti

put_serial	entry
		  begin
		    pshs	b
loop:		    ldb		acia_status

;		  exg	a,b
;		  jsr		puthex
;		  exg	a,b

		    bitb	#tx_empty
		    beq		loop

		    sta		acia_tx
		    puls	b,pc
		  end

get_serial_nw	entry
		  begin
		    ldb		acia_status

		    andb	#rx_full
		    beq		out

		    jsr		get_serial
		    ldb		#1
out:		    rts
		  end

get_serial	entry
		  begin
		    pshs	b
loop:		    ldb		acia_status

		    bitb	#rx_full
		    beq		loop

		    bitb	#parity_error
		    sbeq	over1

		    jsr		parity_mess

over1:		    bitb	#framing_error
		    sbeq	over2

		    jsr		framing_mess

over2:		    bitb	#overrun_error
		    sbeq	over3

		    jsr		overrun_mess

over3:		    lda		acia_rx
		    puls	b,pc
		  end
		end

		begin
message:	  db	"parity error", 13, 10, 0

parity_mess	entry
		  tst	acia_rx
		  ldx	#message
		  jmp	outstring
		end

		begin
message:	  db	"framing error", 13, 10, 0

framing_mess	entry
		  tst	acia_rx
		  ldx	#message
		  jmp	outstring
		end

		begin
message:	  db	"overrun error", 13, 10, 0

overrun_mess	entry
		  tst	acia_rx
		  ldx	#message
		  jmp	outstring

		end
