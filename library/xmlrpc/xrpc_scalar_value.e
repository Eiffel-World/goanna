indexing
	description: "Objects that represent an XML-RPC call and response scalar parameter value."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_SCALAR_VALUE

inherit
	
	XRPC_VALUE
	
creation

	make, make_base64, unmarshall

feature -- Initialisation

	make (new_value: like value) is
			-- Create scalar type from 'new_value'. 'new_value' must be one of the following
			-- types: INTEGER_REF, BOOLEAN_REF, STRING, DOUBLE_REF or DT_DATE_TIME.
		require
			new_value_exists: new_value /= Void
			valid_type: valid_scalar_type (new_value)
		local
			int_ref: INTEGER_REF
			bool_ref: BOOLEAN_REF
			string: STRING
			double_ref: DOUBLE_REF
			date_time: DT_DATE_TIME
		do
			value := new_value
			-- check integer
			int_ref ?= new_value
			if int_ref /= Void then
				type := Int_type
				string_value := value.out
			else
				-- check double
				double_ref ?= new_value
				if double_ref /= Void then
					type := Double_type
					string_value := value.out	
				else
					-- check boolean
					bool_ref ?= new_value
					if bool_ref /= Void then
						type := Bool_type
						bool_ref ?= value
						if bool_ref.item then
							string_value := "1"
						else
							string_value := "0"
						end	
					else
						-- check string
						string ?= new_value
						if string /= Void then
							type := String_type
							string_value := value.out	
						else
							-- check date/time
							date_time ?= new_value
							if date_time /= Void then
								type := Date_time_type
								date_time ?= value
								string_value := format_date_iso8601 (date_time)
							end
						end
					end		
				end
			end
		end

	make_base64 (buffer: STRING) is
			-- Create scalar base64 type from 'buffer'. Encode contents of 'buffer' using
			-- Base64 encoding method.
		require
			buffer_exists: buffer /= Void
		local
			encoder: expanded BASE64_ENCODER
		do
			type := Base64_type
			value := buffer
			string_value := encoder.encode (buffer)
		end

	unmarshall (node: DOM_NODE) is
			-- Unmarshall scalar value from XML node.
		do
		end

feature -- Mashalling

	marshall: STRING is
			-- Serialize this scalar param to XML format
		do	
			create Result.make (100)
			Result.append ("<value><")
			Result.append (type)
			Result.append (">")
			Result.append (string_value)
			Result.append ("</")
			Result.append (type)
			Result.append ("></value>")
		end

feature -- Status report

	value: ANY
			-- Value of this parameter
	
	string_value: STRING
			-- String representation of value
			
	valid_scalar_type (new_value: ANY): BOOLEAN is
			-- Is 'new_value' one of the supported XML-RPC scalar types?
		require
			new_value /= Void
		local
			int_ref: INTEGER_REF
			bool_ref: BOOLEAN_REF
			string: STRING
			double_ref: DOUBLE_REF
			date_time: DT_DATE_TIME
		do
			Result := True
			int_ref ?= new_value
			if int_ref = Void then
				double_ref ?= new_value
				if double_ref = Void then
					bool_ref ?= new_value
					if bool_ref = Void then
						string ?= new_value
						if string = Void then
							date_time ?= new_value
							if date_time = Void then
								Result := False
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	format_date_iso8601 (date: DT_DATE_TIME): STRING is
			-- Format a date time in ISO8601 format
			-- YYYYMMDD'T'HH:MM:SS
		require
			date_exists: date /= Void
		local
			int_format: FORMAT_INTEGER
		do
			create int_format.make (2)
			int_format.zero_fill
			create Result.make (17)
			Result.append (date.year.out)
			Result.append (int_format.formatted (date.month))
			Result.append (int_format.formatted (date.day))
			Result.append_character ('T')
			Result.append (int_format.formatted (date.hour))
			Result.append_character (':')
			Result.append (int_format.formatted (date.minute))
			Result.append_character (':')
			Result.append (int_format.formatted (date.second))
		ensure
			formatted_string_exists: Result /= Void
		end
		
invariant
	
	value_exists: value /= Void
	string_value_exists: string_value /= Void
	
end -- class XRPC_SCALAR_VALUE
