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
	TEST_SOAP

feature -- Basic operations

	test_boolean (in: BOOLEAN_REF): BOOLEAN_REF is
			-- Test boolean type encoding
		do
			Result := in
		end

	test_decimal (in: INTEGER_REF): INTEGER_REF is
			-- Test real type encoding
		do
			Result := in
		end
		
	test_float (in: REAL_REF): REAL_REF is
			-- Test float type encoding
		do
			Result := in
		end
		
	test_double (in: DOUBLE_REF): DOUBLE_REF is
			-- Test double type encoding
		do
			Result := in
		end
		
	test_string (in: STRING): STRING is
			-- Test string type encoding
		do
			Result := in
		end

end -- class TEST_SOAP