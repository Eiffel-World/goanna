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
	Malformed_encoding_style_fault_code: STRING is "MalformedEncodingStyle"
	Malformed_actor_fault_code: STRING is "MalformedActor"
	Malformed_must_understand_fault_code: STRING is "MalformedMustUnderstand"
	
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
			create Result.make (q_code, fault_messages.item (sub_code))
		end
		
	fault_messages: DS_HASH_TABLE [STRING, STRING] is
			-- Table of desciptive fault messages indexed by fully qualified fault codes.
		once
			create Result.make_default
			Result.force ("Envelope element was not found or not well-formed", Missing_envelope_element_fault_code)
			Result.force ("Body element was not found or not well-formed", Missing_body_element_fault_code)
			Result.force ("encodingStyle attribute was malformed or its namespace was incorrect", Malformed_encoding_style_fault_code)
			Result.force ("actor attribute namespace was incorrect", Malformed_actor_fault_code)
			Result.force ("mustUnderstand attribute was malformed or its namespace was incorrect", Malformed_must_understand_fault_code)
		end
		
end -- class SOAP_FAULTS
