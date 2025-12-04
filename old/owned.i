; OWNED.I - definition file for OwnedObject class

;		include "object.i"

OwnedObject	begin
_base		  equ	Object._size
owner		  equ	_base+0	; OwnerObject which ownes this
next_owned	  equ	_base+2	; next object in owned list

_size		  equ	_base+4 ; size of OwnedObject instance
		end

