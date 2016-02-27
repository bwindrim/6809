; OWNER.I - definition file for OwnerObject class

;		include	"owned.i"

OwnerObject	begin
_base		  equ	OwnedObject._size
owned_list	  equ	_base+0	; list of OwnedObjects

_size		  equ	_base+2	; size of OwnerObject instance
		end
