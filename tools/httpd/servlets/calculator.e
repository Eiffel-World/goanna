indexing
	description: "Demo calculator"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."
	
class
	CALCULATOR


feature -- Basic operations

	times (arg1, arg2: DOUBLE_REF): DOUBLE_REF is
			-- Multiply 'arg1' by 'arg2'
		do
			Result := arg1 * arg2
		end
	
	divide (arg1, arg2: DOUBLE_REF): DOUBLE_REF is
			-- Divide 'arg1' by 'arg2'
		do
			Result := arg1 / arg2
		end
	
	minus (arg1, arg2: DOUBLE_REF): DOUBLE_REF is
			-- Subtract 'arg2' from 'arg1'.
		do
			Result := arg2 - arg1
		end
		
	plus (arg1, arg2: DOUBLE_REF): DOUBLE_REF is
			-- Add 'arg1' to 'arg2'
		do
			Result := arg1 + arg2
		end

end -- class CALCULATOR
