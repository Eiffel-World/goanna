indexing
	description: "XML Schema constants"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XML_SCHEMA_CONSTANTS

feature -- Constants

	Xsd_double: STRING is "xsd:double"
	
	Xsd_string: STRING is "xsd:string"
	
	valid_type_constant (type: STRING): BOOLEAN is
			-- Is 'type' a valid XML Schema type constant
		require
			type_exists: type /= Void
		do
			Result := type.is_equal (Xsd_string)
				or type.is_equal (Xsd_double)
		end

end -- class XML_SCHEMA_CONSTANTS
