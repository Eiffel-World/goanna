indexing
	description: "Objects representing agent calls on a target."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SERVICE

creation
	
	make
	
feature
	
	make is
			-- Create new service that will operate on 'new_target'
		do
			create agents.make_default
		end
		
feature -- Status setting

	register (function: like function_anchor; name: STRING) is
			-- Register 'routine' call on 'target' under 'name'.
		require
			name_exists: name /= Void
			function_exists: function /= Void
			function_not_registered: not has (name)
		do
			agents.force (function, name)
		end
		
	has (name: STRING): BOOLEAN is
			-- Is an agent registered under 'name'?
		require
			name_exists: name /= Void
		do
			Result := agents.has (name)
		end
		
	call (name: STRING; args: TUPLE [ANY]) is
			-- Call named function
		local
			function: like function_anchor
		do
			if agents.has (name) then
				function := agents.item (name)
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
	
feature -- Implementation

	agents: DS_HASH_TABLE [like function_anchor, STRING]
			-- Functions that can be called remotely via SOAP messages.
			-- Each function is indexed by a symbolic name and which should 
			-- map to the method name in the SOAP envelope.
	
	function_anchor: FUNCTION [ANY, TUPLE [ANY], ANY]
	
invariant
	
	agents_exists: agents /= Void
	
end -- class SERVICE
