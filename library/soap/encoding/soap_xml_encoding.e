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
			real: REAL_REF
			double: DOUBLE_REF
			qname: Q_NAME
			xsd_type: STRING
		do
			create qname.make_from_qname (type)
			xsd_type := qname.local_name
			if xsd_type.is_equal (Xsd_string) then
				-- xsd:string
				Result := value
			elseif xsd_type.is_equal (Xsd_decimal) then
				Result := unmarshall_decimal (value)
			elseif xsd_type.is_equal (Xsd_float) then
				-- xsd:float
				create real
				if value.is_real then
					real.set_item (value.to_real)
				else
					real.set_item (0.0)
				end
				Result := real
			elseif xsd_type.is_equal (Xsd_double) then
				-- xsd:double
				create double
				if value.is_double then
					double.set_item (value.to_double)
				else
					double.set_item (0.0)
				end
				Result := double
			elseif xsd_type.is_equal (Xsd_boolean) then
				Result := unmarshall_boolean (value)
			end	
		end
	
feature {NONE} -- Implementation

	unmarshall_decimal (value: STRING): ANY is
			-- Unmarshall decimal XML Schema value
		require
			value_exists: value /= Void
		local
			decimal: INTEGER_REF
		do
			create decimal
			if value.is_integer then
				decimal.set_item (value.to_integer)
			else
				decimal.set_item (0)
			end
		end
		
	unmarshall_boolean (value: STRING): ANY is
			-- Unmarshall boolean XML Schema value
		require
			value_exists: value /= Void
		local
			bool: BOOLEAN_REF
		do
			create bool
			if value.is_boolean then
				bool.set_item (value.to_boolean)
			elseif value.is_equal ("1") then
				bool.set_item (True)
			elseif value.is_equal ("0") then	
				bool.set_item (False)
			else
				bool.set_item (False)		
			end
		end
		
end -- class SOAP_XML_ENCODING
