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
		
end -- class CALCULATOR
