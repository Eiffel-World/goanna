indexing
	description: "Mixin class that provides portable bit manipulation routines."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Utility"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	BIT_MANIPULATION

feature -- Basic operations

	bit_shift_right (i, n: INTEGER): INTEGER is
			-- Shift the bits of 'i' right 'n' positions.
		do
			if n > 0 then
				Result := (i.to_bit @>> n).to_integer
			else
				Result := i
			end
		end

	bit_shift_left (i, n: INTEGER): INTEGER is
			-- Shift the bits of 'i' left 'n' positions.
		do
			if n > 0 then
				Result := (i.to_bit @<< n).to_integer
			else
				Result := i
			end
		end
	
	bit_and (i, n: INTEGER): INTEGER is
			-- Bitwise and of 'i' and 'n'
		do
			Result := (i.to_bit and n.to_bit).to_integer
		end
	
	bit_or (i, n: INTEGER): INTEGER is
			-- Bitwise or of 'i' and 'n'
		do
			Result := (i.to_bit or n.to_bit).to_integer
		end

end -- class BIT_MANIPULATION
