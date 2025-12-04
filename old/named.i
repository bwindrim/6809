; NAMED.I - definition file for class NamedObject

;		include	"owner.i"

NamedObject	begin
_base		  equ	OwnerObject._size
name		  equ	_base+0	; object name

_size		  equ	_base+2	; size of NamedObject instance
		end
