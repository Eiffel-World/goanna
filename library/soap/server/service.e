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
	
	make (new_target: ANY) is
			-- Create new service that will operate on 'new_target'
		require
			new_target_exists: new_target /= Void
		do
			target := new_target
			create agent_registry.make
		end
		
feature -- Access

	target: ANY
			-- Target for agent calls
			

	agent_registry: AGENT_REGISTRY
			-- Registry of agent calls that can be called on 'target'

invariant
	
	target_exists: target /= Void
	agent_registry_exists: agent_registry /= Void
	
end -- class SERVICE
