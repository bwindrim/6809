; OBJECT.I - definition file for object class

Object		begin		; named block
_base		  equ	0
class		  equ	_base+0	; class to which object belongs
next_in_class	  equ	_base+2	; next object in this class
destroy		  equ	_base+4	; destructor method

_size		  equ	_base+6	; size of Object instance
		end		; of instance record for object


; method macros

destroy		macro				; destructor
		  jsr	[Object.destroy,x]
		end
