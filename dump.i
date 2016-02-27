		begin
		  begin
intinit:	    ldd		#nmihndl
		    std		nmivec
		    bra		init

init		    redef	intinit
		  end
		  

cc_str:		  db	"cc = ", 0
a_str:		  db	"a  = ", 0
b_str:		  db	"b  = ", 0
dp_str:		  db	"dp = ", 0
x_str:		  db	"x  = ", 0
y_str:		  db	"y  = ", 0
u_str:		  db	"u  = ", 0
pc_str:		  db	"pc = ", 0
sep:		  db	", ", 0
nl:		  db	13, 10, 0

DUMP_BYTE	  macro	reg
		    ldx	  #?reg_str
		    bsr   putstring
		    lda	  ,y+
		    bsr   puthex
		  endm

DUMP_WORD	  macro	reg
		    ldx	  #?reg_str
		    bsr   putstring
		    ldd	  ,y++
		    bsr   puthexword
		  endm

SPACE		  macro
		    ldx	  #sep
		    bsr	  putstring
		  endm

NEWLINE		  macro
		    ldx	  #nl
		    bsr	  putstring
		  endm

nmihndl:	  tfr	s,y
		  dump_byte	cc
		  space
		  dump_byte	a
		  space
		  dump_byte	b
		  space
		  dump_byte	dp
		  space
		  dump_word	x
		  space
		  dump_word	y
		  space
		  dump_word	u
		  space
		  dump_word	pc
		  newline
		  rti
		end
