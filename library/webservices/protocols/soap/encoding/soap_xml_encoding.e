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

	unmarshall (type, value: STRING): SOAP_VALUE is
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
			elseif xsd_type.is_equal (Xsd_int) or xsd_type.is_equal (Xsd_short) then
				-- xsd:int / xsd:short
				Result := unmarshall_int (value)
			elseif xsd_type.is_equal (Xsd_float) or xsd_type.is_equal (Xsd_decimal) then
				-- xsd:float / xsd:decimal
				Result := unmarshall_float (value)
			elseif xsd_type.is_equal (Xsd_double) then
				-- xsd:double
				Result := unmarshall_double (value)
			elseif xsd_type.is_equal (Xsd_boolean) then
				-- xsd:boolean
				Result := unmarshall_boolean (value)
			end	
		end

feature {NONE} -- Implementation

	unmarshall_int (value: STRING): ANY is
			-- Unmarshall int XML Schema value
		require
			value_exists: value /= Void
		local
			int: INTEGER_REF
		do
			create int
			if value.is_integer then
				int.set_item (value.to_integer)
			else
				int.set_item (0)
			end
			Result := int
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
			Result := bool
		end
	
	unmarshall_float (value: STRING): ANY is
			-- Unmarshall float XML Schema value
		require
			value_exists: value /= Void
		local
			float: REAL_REF
		do
			create float
			if value.is_real then
				float.set_item (value.to_real)
			else
				float.set_item (0.0)
			end
			Result := float
		end
	
	unmarshall_double (value: STRING): ANY is
			-- Unmarshall double XML Schema value
		require
			value_exists: value /= Void
		local
			double: DOUBLE_REF
		do		
			create double
			if value.is_double then
				double.set_item (value.to_double)
			else
				double.set_item (0.0)
			end
			Result := double
		end
		
end -- class SOAP_XML_ENCODING
