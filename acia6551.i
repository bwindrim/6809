; I/O register locations

acia_tx		equ	$FE80
acia_rx		equ	acia_tx
acia_reset	equ	$FE81
acia_status	equ	acia_reset
acia_command	equ	$FE82
acia_control	equ	$FE83

; status register flags

parity_error	equ	@00000001
framing_error	equ	@00000010
overrun_error	equ	@00000100
rx_full		equ	@00001000
tx_empty	equ	@00010000
not_dcd		equ	@00100000
not_dsr		equ	@01000000
acia_irq	equ	@10000000

; control register fields

baud_mask	equ	@00001111
baud_ext	equ	@00000000
baud_50		equ	@00000001
baud_75		equ	@00000010
baud_110	equ	@00000011
baud_135	equ	@00000100
baud_150	equ	@00000101
baud_300	equ	@00000110
baud_600	equ	@00000111
baud_1200	equ	@00001000
baud_1800	equ	@00001001
baud_2400	equ	@00001010
baud_3600	equ	@00001011
baud_4800	equ	@00001100
baud_7200	equ	@00001101
baud_9600	equ	@00001110
baud_19200	equ	@00001111
rx_clock	equ	@00010000
word_mask	equ	@01100000
word_8_bits	equ	@00000000
word_7_bits	equ	@00100000
word_6_bits	equ	@01000000
word_5_bits	equ	@01100000
stop_1_bits	equ	@00000000
stop_2_bits	equ	@10000000

; command register fields

acia_enable	equ	@11111111
acia_disable	equ	@00000000
dtr		equ	@00000001
rx_int_disable	equ	@00000010
tx_int_mask	equ	@00001100
tx_disable_nrts	equ	@00000000
tx_enable	equ	@00000100
tx_disable_rts	equ	@00001000
tx_disable_brk	equ	@00001100
rx_echo		equ	@00010000
parity_check	equ	@00100000
parity_mask	equ	@11000000
parity_odd	equ	@00000000
parity_even	equ	@01000000
parity_mark	equ	@10000000
parity_space	equ	@11000000

rx_int		equ	$FFDE
tx_int		equ	$FFDC
dcd_int		equ	$FFDA
dsr_int		equ	$FFD8
cts_int		equ	$FFD6
parity_int	equ	$FFD4
framing_int	equ	$FFD2
overrun_int	equ	$FFD0
unknown2	equ	$FFCE
