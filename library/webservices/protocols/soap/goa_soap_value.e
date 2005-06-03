indexing
	description: "Objects that represent a value in a SOAP envelope."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class	GOA_SOAP_VALUE

inherit
	
	GOA_SOAP_ELEMENT --?? - surely not!
	
feature -- Access

	type: STRING
			-- Type of parameter (used as the tag value)

feature -- Conversion

	as_object: ANY is
			-- Return value as an object. ie, extract the actual 
			-- object value from the GOA_SOAP_VALUE.
		deferred
		end
		
invariant
	
	type_exists: validated implies type /= Void
		
end -- class GOA_SOAP_VALUE
