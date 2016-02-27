; SHARED.I - definition file for class SharedObject

;		include	"named.i"

SharedObject	begin
_base		  equ	NamedObject._size
ref_list	  equ	_base+0	; list of references
ref_destroy	  equ	_base+2	; method to really destroy shared object

_size		  equ	_base+4
		end


ref_destroy	macro
		  jsr	[SharedObject.real_destroy,x]
		end
