PT_WAITING      equ         0
PT_YIELDED      equ         1
PT_EXITED       equ         2
PT_ENDED        equ         3

PT_INIT         macro       name
                    leay     ?name.start,pcr
                    sty     ,x
                endm

PT_BEGIN        macro       name
?name                       begin
run:                pshs    y
                    jmp     [,x]
start:
                endm

PT_END          macro
                    leay    .start,pcr
                    sty     ,x
                    lda     #PT_ENDED
                    puls    y,pc             ; return
                    end
                endm

PT_YIELD        macro
                begin
;                leay        .continue,pcr
                ldy         #.continue   ; NOTE: not position-independent!
                sty         ,x
                lda         #PT_YIELDED
                puls    y,pc             ; return
continue:
                end
                endm

PT_WAIT         macro
                begin
                leay        .continue,pcr
                sty         ,x
                lda         #PT_WAITING
                puls    y,pc             ; return
continue:
                end
                endm

PT_EXIT         macro
                leay        .start,pcr
                sty         ,x
                lda         #PT_EXITED
                puls        y,pc
                endm
