
rx_stream	stream
tx_stream	stream

		begin
prev_bits	  db		0
cts_state	  db		1		; initially true
saved_flag	  db		0
saved_char	  db		0
trans_flag	  db		0
flow_limit	  db		10
acia_unknown	  dw		0

		  begin
intinit:	    sta		acia_reset
		    lda		acia_status
		    anda	#(not_dcd | not_dsr)
		    sta		prev_bits
		    ldd		irqvec
		    std		acia_unknown
		    ldd		#acia_inthndl
		    std		irqvec
		    lda		#dtr | tx_enable | parity_check | parity_even
		    sta		acia_command
		    lda		#rx_clock | word_8_bits | stop_1_bits | baud_9600
		    sta		acia_control
		    bra		init

init		    redef	intinit
		  end

acia_inthndl:	  begin
		    lda		acia_status
		    sbmi	int_here	; if top bit not set then

out:		    jmp		[acia_unknown]	; interrupt not from here

int_here:	    tfr		a,b
		    
		    andb	#(not_dcd | not_dsr)
		    sbeq	zero
not_zero:	    eorb	prev_bits
		    sbeq	unchanged_not_zero

check_flags:	    anda	#(not_dcd | not_dsr)
		    sta		prev_bits
		    bitb	#not_dsr
		    beq		dsr_same

		    bita	#not_dsr
		    bne		dsr_gone_false
		    bra		dsr_gone_true

dsr_same:	    bitb	#not_dcd
		    beq		dcd_same

		    bita	#not_dcd
		    bne		dcd_gone_false
		    bra		dcd_gone_true

dcd_same:	    rti


unchanged_not_zero: rti    

zero:		    eorb	prev_bits
		    bne		check_flags

unchanged_zero:	    bita	#(rx_full | tx_empty)
		    beq		cts_false

		    bita	#rx_full
		    bne		receive_data

		    bita	#tx_empty
		    bne		transmit_data

		    rti
		  end

receive_data:	  begin
		    ldb		acia_status
		    lda		acia_rx

		    bitb	#parity_error
		    sbeq	over1

		    bsr		parity_mess

over1:		    bitb	#framing_error
		    sbeq	over2

		    bsr		framing_mess

over2:		    bitb	#overrun_error
		    sbeq	over3

		    bsr		overrun_mess
		    rti

over3:		    ldx		#rx_stream
		    ldy		#rx_wakeup
		    putcharwake
		    tstb
		    bne		still_space

		    bsr		full_mess
		    rti

still_space:	    cmpb	flow_limit
		    bhs		no_stop

		    bsr		stop_flow

no_stop:	    rti
		  end

stop_flow:	  begin
		    lda		acia_command
		    anda	#!tx_int_mask
		    sta		acia_command
		    rts
		  end

rx_wakeup:	  begin
		    lda		acia_command
		    ora		#tx_enable
		    sta		acia_command
		    rts
		  end

transmit_data:	  begin		; cts must be true if we got here
		    clr		trans_flag	; previous trans completed
		    tst		cts_state	; compare with previous state
		    bne		over		; no change

		    ; cts_state is zero
		    inc		cts_state	; cts state changed
		    lsr		saved_flag	; check if retrans required
		    bcc		over		; if not then proceed

		    lda		saved_char	; if so then send saved char
		    bra		send

over:		    ldx		#tx_stream
		    getcharnw
		    tstb
		    beq		exit		; no data

		    sta		saved_char
send:		    sta		acia_tx		; put byte in transmit reg.
		    inc		trans_flag	; sending again
exit:		    rti
		  end

dsr_gone_false:	  begin
		    lda		acia_command
		    ora		#rx_int_disable
		    anda	#!tx_int_mask
		    sta		acia_command
		    rti
		  end

dsr_gone_true:	  begin
		    lda		acia_command
		    anda	#!rx_int_disable
		    ora		#tx_enable
		    sta		acia_command
		    rti
		  end

dcd_gone_false:	  begin
		    bsr		dcd_mess
		    rti
		  end

dcd_gone_true:	  begin
		    bsr		dcd_mess
		    rti
		  end

cts_false:	  begin
		    tst		cts_state
		    beq		no_change

		    clr		cts_state	; cst_state is false
		    lsr		trans_flag	; if transmitting then clear
		    rol		saved_flag	; and set flag for retrans

no_change:	    rti
		  end
		end

		begin
message:	  db	"parity error", 13, 10, 0

parity_mess	entry
		  ldx	stderr
		  lda	#14
		  putblknw
		  rts
		end

		begin
message:	  db	"framing error", 13, 10, 0

framing_mess	entry
		  lda	#15
		  ldx	stderr
		  putblknw
		  rts
		end

		begin
message:	  db	"overrun error", 13, 10, 0

overrun_mess	entry
		  lda	#15
		  ldx	stderr
		  putblknw
		  rts
		end

		begin
message:	  db	"input buffer full error", 13, 10, 0

full_mess	entry
		  lda	#25
		  ldx	stderr
		  putblknw
		  rts
		end

		begin
message:	  db	"error: dcd state change", 13, 10, 0

dcd_mess	entry
		  lda	#23
		  ldx	stderr
		  putblknw
		  rts
		end
