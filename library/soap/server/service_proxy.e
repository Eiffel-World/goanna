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
	
	REGISTRY [FUNCTION [ANY, TUPLE [ANY], ANY]]
	
creation
	
	make
		
feature -- Status setting

	call (name: STRING; args: TUPLE [ANY]) is
			-- Call named function
		local
			function: FUNCTION [ANY, TUPLE [ANY], ANY]
		do
			if has (name) then
				function := get (name)
				function.call (args)
				last_result := function.last_result
				process_ok := True
			else
				--last_result := Void
				process_ok := False
			end	
		end
	
	process_ok: BOOLEAN
	
	last_result: ANY

end -- class SERVICE_PROXY
