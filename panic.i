        ; panic.i - fatal error handler for 6809

PANIC   macro   msg
            swi
            db      ?msg, 0
        endm
