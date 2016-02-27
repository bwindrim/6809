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

enable		equ	@10000000
disable		equ	@00000000

ca2flag		equ	@00000001
ca1flag		equ	@00000010
srflag		equ	@00000100
cb2flag		equ	@00001000
cb1flag		equ	@00010000
t2flag		equ	@00100000
t1flag		equ	@01000000
