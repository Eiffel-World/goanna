indexing
	description: "Registry of SOAP encodings"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_ENCODING_REGISTRY

inherit

	REGISTRY [SOAP_ENCODING]
	
create
	make

feature -- Status checking

	valid_type (scheme, type: STRING): BOOLEAN is
			-- Is 'type' a valid type in encoding scheme 'scheme'
		require
			scheme_exists: scheme /= Void
			type_exists: type /= Void
			scheme_registered: has (scheme)
		do
			Result := get (scheme).valid_type (type)
		end
		
feature -- Transformation

	unmarshall (scheme, type, value: STRING): ANY is
			-- Unmarshall 'value' of 'type' using the registered
			-- 'scheme'
		require
			scheme_exists: scheme /= Void
			type_exists: type /= Void
			value_exists: value /= Void
			scheme_registered: has (scheme)
		do
			Result := get (scheme).unmarshall (type, value)
		end

	marshall (scheme: STRING; value: ANY): DS_PAIR [STRING, STRING] is
			-- Marshall 'value' to pair containing type and string value
			-- using the registered 'scheme'
		require
			scheme_exists: scheme /= Void
			value_exists: value /= Void
			scheme_registered: has (scheme)
		do
			Result := get (scheme).marshall (value)
		ensure
			value_pair_exists: Result /= Void
		end
		
end -- class SOAP_ENCODING_REGISTRY
