indexing
	description: "Introspection services for XML-RPC servers."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_SYSTEM

inherit
	
	SERVICE

	SHARED_SERVICE_REGISTRY
		export
			{NONE} all
		end
	
	INTERNAL
		export
			{NONE} all
		end
		
create

	make
	
feature -- Access

	list_methods: ARRAY [STRING] is
			-- List all available methods
		local
			service_cursor: DS_HASH_TABLE_CURSOR [SERVICE_PROXY, STRING]
			method_cursor: DS_HASH_TABLE_CURSOR [ROUTINE [ANY, TUPLE], STRING]
			service: SERVICE_PROXY
			names: DS_LINKED_LIST [STRING]
			name: STRING
		do
			create names.make_default
			from
				service_cursor := registry.elements.new_cursor
				service_cursor.start
			until
				service_cursor.off
			loop
				service := service_cursor.item
				from
					method_cursor := service.elements.new_cursor
					method_cursor.start
				until
					method_cursor.off
				loop
					create name.make (service_cursor.key.count + 1 + method_cursor.key.count)
					name.append (service_cursor.key)
					name.append (".")
					name.append (method_cursor.key)
					names.force_last (name)
					method_cursor.forth
				end
				service_cursor.forth
			end
			-- convert to array
			Result := names.to_array
		ensure
			method_list_exists: Result /= Void
		end
	
	method_signature (method_name: STRING): ARRAY [ARRAY [STRING]] is
			-- List the signatures for the method named 'method_name'.
			-- TIt returns an array of possible signatures for this method. 
			-- A signature is an array of types. The first of these types is 
			-- the return type of the method, the rest are parameters.
			--
			-- Multiple signatures (ie. overloading) are permitted: this is the 
			-- reason that an array of signatures are returned by this method.
			-- 
			-- Signatures themselves are restricted to the top level parameters 
			-- expected by a method. For instance if a method expects one array of 
			-- structs as a parameter, and it returns a string, its signature is simply 
			-- "string, array". If it expects three integers, its signature 
			-- is "string, int, int, int".
		require
			method_name_exists: method_name /= Void
			method_registered: has_method (method_name).item
		do
		ensure
			signature_exists: Result /= Void
		end
	
	method_help (method_name: STRING): STRING is
			-- Return the documentation for the named method.
		require
			method_name_exists: method_name /= Void
			method_registered: has_method (method_name).item
		local
			service, method: STRING
			i: INTEGER
		do
			i := method_name.index_of ('.', 1)
			service := method_name.substring (1, i - 1)
			method := method_name.substring (i + 1, method_name.count)
			Result := registry.get (service).help (method)
		ensure
			help_exists: Result /= Void
		end
		
	has_method (method_name: STRING): BOOLEAN_REF is
			-- Is a service registered with the name 'method_name'?
			-- This routine is a non-standard extension to the XML-RPC 
			-- introspection API.
		require
			method_name_exists: method_name /= Void
			method_name_size: method_name.count >= 3
			valid_method_name: method_name.index_of ('.', 1) > 0
		local
			service, method: STRING
			i: INTEGER
		do
			i := method_name.index_of ('.', 1)
			service := method_name.substring (1, i - 1)
			method := method_name.substring (i + 1, method_name.count)
			create Result
			if registry.has (service) then
				Result.set_item (registry.get (service).has (method))
			end
		ensure
			result_exists: Result /= Void
		end
			
feature {NONE} -- Initialisation

	self_register is
			-- Register all actions for this service
		do		
			register_with_help (agent list_methods, "listMethods", "Enumerate all methods implemented by this server")
--			register_with_help (agent method_signature, "methodSignature", "Return the possible signatures for the named method")
			register_with_help (agent method_help, "methodHelp", "Return the documentation string for the named method")
			register_with_help (agent has_method, "hasMethod", "Determine if a named method implemented by this server")
		end

end -- class XRPC_SYSTEM
