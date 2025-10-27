portb		equ	$FE00	; 6522 register offsets
porta		equ	$FE01
ddrb		equ	$FE02
ddra		equ	$FE03
t1cl		equ	$FE04
t1ch		equ	$FE05
t1ll		equ	$FE06
t1lh		equ	$FE07
t2cl		equ	$FE08
t2ch		equ	$FE09
sr		equ	$FE0A
acr		equ	$FE0B
pcr		equ	$FE0C
ifr		equ	$FE0D
ier		equ	$FE0E
portaAlt	equ	$FE0F

; Peripheral Control Register (PCR) bits
CA1_NEGATIVE	equ	@00000000
CA1_POSITIVE	equ	@00000001
CA2_NEGATIVE	equ	@00000000
CA2_POSITIVE	equ	@00000010
CA2_IND_INT_NEG	equ	@00000100
CA2_IND_INT_POS	equ	@00000110
CA2_HANDSHAKE	equ	@00001000
CA2_PULSE	    equ	@00001010
CA2_LOW	        equ	@00001100
CA2_HIGH	    equ	@00001110
CB1_NEGATIVE	equ	@00000000
CB1_POSITIVE	equ	@00010000
CB2_NEGATIVE	equ	@00000000
CB2_POSITIVE	equ	@00100000
CB2_IND_INT_NEG	equ	@01000000
CB2_IND_INT_POS	equ	@01100000
CB2_HANDSHAKE	equ	@10000000
CB2_PULSE	    equ	@10100000
CB2_LOW	        equ	@11000000
CB2_HIGH	    equ	@11100000

; Auxiliary Control Register (ACR) bits
PA_LATCH_DISABLE	equ	@00000000
PA_LATCH_ENABLE	    equ	@00000001
PB_LATCH_DISABLE	equ	@00000000
PB_LATCH_ENABLE	    equ	@00000010
SHIFT_DISABLE	    equ	@00000000
SHIFT_IN_T2	        equ	@00000100
SHIFT_IN_PHI2	    equ	@00001000
SHIFT_IN_EXT	    equ	@00001100
SHIFT_OUT_T2_FREE	equ	@00010000
SHIFT_OUT_T2_SYNC	equ	@00010100
SHIFT_OUT_PHI2	    equ	@00011000
SHIFT_OUT_EXT       equ	@00011100
T2_TIMED_INT        equ	@00000000
T2_COUNT_PB6	    equ	@00100000
T1_ONE_SHOT   	    equ	@00000000
T1_CONTINUOUS	    equ	@01000000
T1_PB7      	    equ	@10000000

; Interrupt Flag Register (IFR) and Interrupt Enable Register (IER) bits
ca2flag		equ	@00000001
ca1flag		equ	@00000010
srflag		equ	@00000100
cb2flag		equ	@00001000
cb1flag		equ	@00010000
t2flag		equ	@00100000
t1flag		equ	@01000000
enable		equ	@10000000
disable		equ	@00000000
