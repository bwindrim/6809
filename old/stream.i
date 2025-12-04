STREAM		macro
		  dw	0
		  db	0
		  db	5
		  ds	128
		  db	"start"
		  ds	128-5
;		  db	0, 0
;		  ds	256
		endm

GETCHAR		macro
		  jsr	sgetchar
		endm

GETCHARNW	macro
		  jsr	sgetcharnw
		endm

GETCHARWAKE	macro
		  jsr	sgetcharwake
		endm

PUTCHAR		macro
		  jsr	sputchar
		endm

PUTCHARNW	macro
		  jsr	sputcharnw
		endm

PUTCHARWAKE	macro
		  jsr	sputcharwake
		endm

GETBLK		macro
		  jsr	sgetblknw
		endm

GETBLKNW	macro
		  jsr	sgetblknw
		endm

GETBLKWAKE	macro
		  jsr	sgetblkwake
		endm

PUTBLK		macro
		  jsr	sputblk
		endm

PUTBLKNW	macro
		  jsr	sputblknw
		endm

PUTBLKWAKE	macro
		  jsr	sputblkwake
		endm

		begin
wakeup		  equ	0
readptr		  equ	2
writeptr	  equ	3
buffer		  equ	132


sgetcharnw	entry
		  begin
		    pshs	y,cc
		    seif
		    ldb		readptr,x
		    cmpb	writeptr,x
		    sbne	get

		    clrb
		    puls	y,cc,pc
		  end

sgetcharwake	entry
		  begin
		    pshs	cc
		    seif
		    jsr		sgetcharnw
		    tstb
		    sbne	nosleep

		    sty		wakeup,x
nosleep:	    puls	cc,pc
		  end

sgetchar	entry
		  begin
		    pshs	y,cc
loop:		    clif
		    seif
		    ldb		readptr,x
		    cmpb	writeptr,x
		    beq		loop
		  end

get:		  begin
		    leay	buffer,x
		    lda		b,y
		    incb 
		    stb		readptr,x
		    subb	writeptr,x
		    cmpb	#2
		    sbne	nopending

		    ldy		wakeup,x
		    sbeq	nopending

		    clr		wakeup,x
		    clr		wakeup+1,x
		    jsr		,y

nopending:	    ldb		#-1
		    puls	y,cc,pc
		  end

sputcharnw	entry
		  begin
		    pshs	y,cc
		    seif
		    ldb		writeptr,x ;test for only one space left (full)
		    subb	readptr,x
		    incb
		    sbne	put

		    puls	y,cc,pc
		  end

sputcharwake	entry
		  begin
		    pshs	cc
		    seif
		    jsr		sputcharnw
		    tstb
		    sbne	nosleep

full:		    sty		wakeup,x
nosleep:	    puls	cc,pc
		  end

sputchar	entry
		  begin
		    pshs	y,cc
fullwait:	    clif
		    seif
		    ldb		writeptr,x	; test for only one space left (full)
		    subb	readptr,x
		    incb
		    beq		fullwait
		  end

put:		  begin
		    leay	buffer,x
		    ldb		writeptr,x
		    sta		b,y
		    incb
		    stb		writeptr,x
		    subb	readptr,x
		    cmpb	#1
		    sbne	nowaiting

		    ldy		wakeup,x
		    sbeq	nowaiting

		    clr		wakeup,x
		    clr		wakeup+1,x
		    jsr		,y

nowaiting:	    ldb		#-1
		    puls	y,cc,pc
		  end

sputblknw	entry
		  begin
		    pshs	u,cc
		    sta		,-s
		    seif
		    ldb		readptr,x	; test for not enough space left
		    subb	writeptr,x
		    decb
		    cmpb	,s
		    sbhs	putblk

		    clrb
		    leas	1,s
		    puls	u,cc,pc
		  end

sputblkwake	entry
		  begin
		    pshs	cc
		    seif
		    jsr		sputblknw
		    tstb
		    sbne	nosleep

full:		    sty		wakeup,x
nosleep:	    puls	cc,pc
		  end

sputblk		entry
		  begin
		    pshs	u,cc
		    sta		,-s
fullwait:	    clif
		    seif
		    ldb		readptr,x	; test for not enough space left
		    subb	writeptr,x
		    decb
		    cmpb	,s
		    sblo	fullwait	; wait for space
		  end

putblk:		  begin
		    leau	buffer,x
		    ldb		writeptr,x
copyloop:	    lda		,y+
		    sta		b,u
		    incb
		    dec		,s
		    bne	copyloop

		    leas	1,s
		    stb		writeptr,x
		    subb	readptr,x
		    cmpb	#128
		    sbhi	nowaiting

		    ldy		wakeup,x
		    sbeq	nowaiting

		    clr		wakeup,x
		    clr		wakeup+1,x
		    jsr		,y

nowaiting:	    ldb		#-1
		    puls	u,cc,pc
		  end

sgetblkwake	entry
		  begin
		    pshs	cc
		    seif
;		    jsr		sgetblknw
		    tstb
		    sbne	nosleep

		    sty		wakeup,x
nosleep:	    puls	cc,pc
		  end


space		entry
		  begin
		    pshs	cc
		    seif

		    ldb		readptr,x  ;test space left in buffer
		    subb	writeptr,x
		    decb

		    puls	cc,pc
		  end
		end

