indexing
	description: "Test SOAP service"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	TEST_SOAP_INTEROP

inherit
	
	SERVICE

creation
	
	make
	
feature -- Basic operations

	echo_void (in: ANY): ANY is
			-- echo Void
		do
		end
	
	echo_boolean (in: BOOLEAN_REF): BOOLEAN_REF is
			-- Echo boolean
		do
			Result := in
		end

	echo_integer (in: INTEGER_REF): INTEGER_REF is
			-- Echo integer
		do
			Result := in
		end
		
	echo_float (in: REAL_REF): REAL_REF is
			-- Echo float type encoding
		do
			Result := in
		end
		
	echo_double (in: DOUBLE_REF): DOUBLE_REF is
			-- Echo double type encoding
		do
			Result := in
		end
		
	echo_string (in: STRING): STRING is
			-- Echo string
		do
			Result := in
		end

feature -- Status setting

	self_register is
			-- Register all facilities of Current in 'registry'.
		do
			register (~echo_void (?), "echoVoid")
			register (~echo_boolean (?), "echoBoolean")
			register (~echo_integer (?), "echoInteger")
			register (~echo_float (?), "echoFloat")
			register (~echo_double (?), "echoDouble")
			register (~echo_string (?), "echoString")
		end
		
end -- class TEST_SOAP_INTEROP