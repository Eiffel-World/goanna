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
		
	process_ok: BOOLEAN
			-- Did the last execution of this service succeed?
	
	last_result: ANY
			-- The result of the last execution. Void if no result.

	help (name: STRING): STRING is
			-- Documentation for the named service.
		require
			name_exists: name /= Void
			service_exists: has (name)
		do
			if routine_help /= Void and then routine_help.has (name) then
				Result := routine_help.item (name)		
			else
				Result := ""
			end			
		end
			
feature -- Status setting

	register_with_help (element: ROUTINE [ANY, TUPLE]; name, help_string: STRING) is
			-- Register 'element' with 'name' and 'help_string'
		require
			name_exists: name /= Void
			element_exists: element /= Void
			help_exists: help_string /= Void
		do
			elements.force (element, name)
			set_help (name, help_string)
		ensure
			element_registered: has (name)
			help_set: help (name).is_equal (help_string)
		end
		
	call (name: STRING; args: TUPLE) is
			-- Call named routine
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

	set_help (name, help_string: STRING) is
			-- Set the help string for the named routine.
		require
			name_exists: name /= Void
			service_exists: has (name)
			help_exists: help_string /= Void
		do
			if routine_help = Void then
				create routine_help.make_default
			end
			routine_help.force (help_string, name)
		ensure
			help_set: help (name).is_equal (help_string)
		end
		
feature -- Implementation

	routine_help: DS_HASH_TABLE [STRING, STRING]
			-- Help strings for individual routine of this service.
		
end -- class SERVICE_PROXY
