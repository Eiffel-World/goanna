indexing
	description: "Factory that correctly unmarshalls SOAP value objects depending on encoding styles."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class	GOA_SOAP_VALUE_FACTORY

inherit
	
	GOA_SOAP_CONSTANTS
		export
			{NONE} all
		end

	GOA_SHARED_ENCODING_REGISTRY
	
		-- TODO: - needs lot's of work
		-- can't be used yet - part of the SOAP Encoding adjunct

creation
	
	make
	
feature -- Initialisation

	make is
			-- Initialise
		do
			unmarshalled := True
			unmarshalling_fault := Void
			last_value := Void
		end
		
feature -- Status report

	last_value: GOA_SOAP_VALUE
			-- Last value unmarshalled.
			
	unmarshalled: BOOLEAN
			-- Was unmarshalling performed successfully?
			
	unmarshalling_fault: GOA_SOAP_FAULT_INTENT
			-- Fault representing unmarshalling error.
	
feature -- Factory

	unmarshall_value (value: STRING; encoding_style, type: STRING) is
			-- Unmarshall 'value' according to 'type' as defined in 'encoding_style'. Make
			-- result available in 'last_value'.
		do
			make	
		end
		
	build (value: ANY; encoding_style: STRING) is
			-- Build a new SOAP value from 'value' according to 'encoding_style'. 
			-- Make value available in 'last_value'.
		require
			value_exists: value /= Void
		do
			make
		end
		
invariant
	
	unmarshalling_error: last_value = Void implies unmarshalling_fault /= Void
	marshalling_ok: unmarshalled implies unmarshalling_fault = Void

end -- class GOA_SOAP_VALUE_FACTORY
