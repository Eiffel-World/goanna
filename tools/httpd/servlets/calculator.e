indexing
	description: "Demo calculator"
	
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
