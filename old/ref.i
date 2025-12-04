; REF.I - definition file for class Reference

		include	"owned.i"

Reference	begin
_base		  equ	OwnedObject._size
ref_to		  equ	_base+0	; pointer to referenced object
next_ref	  equ	_base+2	; next reference in list

_size		  equ	_base+4
		end

