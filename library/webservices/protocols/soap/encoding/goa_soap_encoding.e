indexing
	description: "Abstract SOAP XML encoding scheme"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class GOA_SOAP_ENCODING

feature -- Status checking

	valid_type (type: STRING): BOOLEAN is
			-- Is 'type' a known data type in this encoding scheme?
		require
			type_exists: type /= Void
		deferred
		end

	was_valid: BOOLEAN
			-- Was a validation error detected?

	validation_fault: GOA_SOAP_FAULT_INTENT
			-- Fault generated when not `was_valid'.

feature -- Validation

	validate_references (an_element: GOA_SOAP_ELEMENT; unique_identifiers: DS_HASH_TABLE [GOA_SOAP_ELEMENT, STRING]; an_identity: UT_URI) is
			-- Validate references from `an_element' and set `was_valid'.
		require
			element_not_void: an_element /= Void
			unique_identifiers_not_void: unique_identifiers /= Void
			identity_not_void: an_identity /= Void
		deferred
		end

	validate_encoding_information (an_element: GOA_SOAP_ELEMENT; unique_identifiers: DS_HASH_TABLE [GOA_SOAP_ELEMENT, STRING]; an_identity: UT_URI) is
			-- Validate `an_element' in isolation and set `was_valid'.
		require
			element_not_void: an_element /= Void
			unique_identifiers_not_void: unique_identifiers /= Void
			identity_not_void: an_identity /= Void
		deferred
		end

feature -- Unmarshalling

	unmarshall (type, value: STRING): GOA_SOAP_VALUE is
			-- Unmarshall 'value' according to 'type' using the 
			-- current encoding scheme.
		require
			type_exists: type /= Void
			value_exists: value /= Void
		deferred
		end

invariant
	
	validate: was_valid implies validation_fault = Void
	
end -- class GOA_SOAP_ENCODING
