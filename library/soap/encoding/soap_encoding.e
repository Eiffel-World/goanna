indexing
	description: "Abstract SOAP XML encoding scheme"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	SOAP_ENCODING

feature -- Status checking

	valid_type (type: STRING): BOOLEAN is
			-- Is 'type' a known data type in this encoding scheme?
		require
			type_exists: type /= Void
		deferred
		end
		
feature -- Unmarshalling

	unmarshall (type, value: STRING): ANY is
			-- Unmarshall 'value' according to 'type' using the 
			-- current encoding scheme.
		require
			type_exists: type /= Void
			value_exists: value /= Void
		deferred
		end
		
end -- class SOAP_ENCODING
