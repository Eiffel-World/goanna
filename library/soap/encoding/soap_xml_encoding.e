indexing
	description: "SOAP XML encoding corresponds to http://schemas.xmlsoap.org/soap/encoding/"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_XML_ENCODING

inherit
	
	SOAP_ENCODING
	
	XML_SCHEMA_CONSTANTS
		rename
			valid_type_constant as valid_type
		export
			{NONE} all
		end
		
feature -- Unmarshalling

	unmarshall (type, value: STRING): ANY is
			-- Unmarshall 'value' according to 'type' using this 
			-- encoding scheme.
		local
			double: DOUBLE_REF
		do
			if type.is_equal ("xsd:string") then
				Result := value
			elseif type.is_equal ("xsd:double") then
				create double
				if value.is_double then
					double.set_item (value.to_double)
				else
					double.set_item (0.0)
				end
				Result := double
			end	
		end
		
end -- class SOAP_XML_ENCODING
