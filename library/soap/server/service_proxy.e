indexing
	description: "Objects representing a proxy to a service."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SERVICE_PROXY
	
inherit
	
--	REGISTRY [FUNCTION [ANY, TUPLE, ANY]]
	REGISTRY [ROUTINE [ANY, TUPLE]]
	
creation
	
	make
	
feature -- Status report

	valid_operands (name: STRING; operands: TUPLE): BOOLEAN is
			-- Are 'operands' valid operands for the function named 'name'?
		require
			name_exists: name /= Void
			service_exists: has (name)
			args_exist: operands /= Void
		do
			Result := get (name).valid_operands (operands)
		end
		
feature -- Status setting

	call (name: STRING; args: TUPLE) is
			-- Call named function
		local
			function: FUNCTION [ANY, TUPLE, ANY]
			routine: ROUTINE [ANY, TUPLE]
		do
			last_result := Void
			if has (name) then
				routine := get (name)
				-- check if it is a function so that a result is returned
				function ?= routine
				if function /= Void then
					function.call (args)
					last_result := function.last_result
				else
					routine.call (args)
				end
				process_ok := True
			else
				process_ok := False
			end	
		end
	
	process_ok: BOOLEAN
	
	last_result: ANY

end -- class SERVICE_PROXY
