indexing
	description: "Test service. Provides test calls for all types"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XMLRPC examples test"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	TEST

inherit
	
	SERVICE
		
creation
	
	make
			
feature -- Access
			
	echo_int (arg: INTEGER_REF): INTEGER_REF is
			-- Echo an integer argument
		do
			Result := arg
		end
	
	echo_bool (arg: BOOLEAN_REF): BOOLEAN_REF is
			-- Echo a boolean argument
		do
			Result := arg
		end
		
	echo_string (arg: STRING): STRING is
			-- Echo a string argument
		do
			Result := arg
		end
		
	echo_double (arg: DOUBLE_REF): DOUBLE_REF is
			-- Echo a double argument
		do
			Result := arg
		end
		
	echo_date_time (arg: DT_DATE_TIME): DT_DATE_TIME is
			-- Echo a date/time argument
		do
			Result := arg
		end
	
	echo_base64 (arg: STRING): STRING is
			-- Echo a base64 string.
		do
			Result := arg
		end
		
	echo_decoded_base64 (arg: STRING): STRING is
			-- Echo a base64 string. Return the string decoded.			
		do
			Result := arg
		end
		
	echo_array (arg: ARRAY [ANY]): ARRAY [ANY] is
			-- Echo an array.
		do
			Result := arg
		end
		
	echo_struct (arg: DS_HASH_TABLE [ANY, STRING]): DS_HASH_TABLE [ANY, STRING] is
			-- Echo a struct
		do
			Result := arg
		end	
	
feature {NONE} -- Initialisation

	self_register is
			-- Register all actions for this service
		do	
			register (agent echo_int, "echoInt")
			register (agent echo_bool, "echoBool")
			register (agent echo_string, "echoString")
			register (agent echo_double, "echoDouble")
			register (agent echo_date_time, "echoDateTime")
			register (agent echo_base64, "echoBase64")
			register (agent echo_decoded_base64, "echoDecodedBase64")
			register (agent echo_array, "echoArray")
			register (agent echo_struct, "echoStruct")			
		end

end -- class TEST
