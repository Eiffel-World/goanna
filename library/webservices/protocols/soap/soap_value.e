indexing
	description: "Objects that represent a value in a SOAP envelope."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	SOAP_VALUE

inherit
	
	SOAP_ELEMENT
	
feature -- Access

	type: UC_STRING
			-- Type of parameter (used as the tag value)

feature -- Conversion

	as_object: ANY is
			-- Return value as an object. ie, extract the actual 
			-- object value from the SOAP_VALUE.
		deferred
		end
		
invariant
	
	type_exists: unmarshall_ok implies type /= Void
		
end -- class SOAP_VALUE
