indexing
	description: "SOAP fault constants and utility routines"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_FAULTS

feature -- Fault constants

	Missing_envelope_element_fault_code: STRING is "MissingEnvelope"
	Missing_body_element_fault_code: STRING is "MissingBody"
	
feature -- Basic routines

	create_fault (code, sub_code: STRING): SOAP_FAULT is
			-- Create a fault with the specified 'code' and 'sub_code'. 'sub_code' may be ommitted.
			-- Add 'faulterror' message from the 'fault_message' table given the sub-code.
		require
			code_exists: code /= Void
		local
			q_code: STRING
		do
			if sub_code /= Void then
				q_code := code + "." + sub_code
			else
				q_code := code
			end
			create Result.make (create {UC_STRING}.make_from_string (q_code), 
				create {UC_STRING}.make_from_string (fault_messages.item (sub_code)))
		ensure
			correct_fault_code: sub_code /= Void implies Result.fault_code.out.is_equal (code + "." + sub_code)
				or else sub_code = Void implies Result.fault_code.out.is_equal (code)
			correct_fault_string: Result.fault_string.out.is_equal (fault_messages.item (sub_code))
		end
		
	fault_messages: DS_HASH_TABLE [STRING, STRING] is
			-- Table of desciptive fault messages indexed by fully qualified fault codes.
		once
			create Result.make_default
			Result.force ("Envelope element was not found or not well-formed", Missing_envelope_element_fault_code)
			Result.force ("Body element was not found or not well-formed", Missing_body_element_fault_code)
		end
		
end -- class SOAP_FAULTS
