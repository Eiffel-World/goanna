indexing
	description: "Objects that represent an XML-RPC call."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_CALL

inherit
	
	XRPC_ELEMENT
	
creation
	
	make, unmarshall
	
feature -- Initialisation

	make (new_method: STRING) is
			-- Initialise 
		require
			new_method_exists: new_method /= Void
		do
			method_name := new_method
			create params.make_default
			unmarshall_ok := True
		end
		
	unmarshall (node: DOM_ELEMENT) is
			-- Initialise XML-RPC call from DOM element.
		local
			method_name_elem, params_elem, next_param: DOM_ELEMENT
			param_set: DOM_NODE_LIST
			param: XRPC_PARAM
			i: INTEGER
		do
			unmarshall_ok := True
			create params.make_default
			method_name_elem := get_named_element (node, Method_name_element)
			if method_name_elem /= Void then
				-- set method name
				method_name := method_name_elem.first_child.node_value.out
				-- check for parameters
				params_elem := get_named_element (node, Params_element)
				if params_elem /= Void then
					-- unmarshall all parameters
					if params_elem.has_child_nodes then		
						param_set := params_elem.child_nodes
						-- unmarshall each parameter
						from
							i := 0
						until
							i >= param_set.length or not unmarshall_ok
						loop
							next_param ?= param_set.item (i)
							check
								param_is_element: next_param /= Void
							end
							create param.unmarshall (next_param)
							if param.unmarshall_ok then
								params.force_last (param)
							else
								unmarshall_ok := False
								unmarshall_error_code := param.unmarshall_error_code
							end
							i := i + 1
						end
					end
				end
			else
				unmarshall_ok := False
				unmarshall_error_code := Method_name_element_missing
			end
		end
	
feature -- Access

	method_name: STRING
			-- Name of method to call
			
	params: DS_LINKED_LIST [XRPC_PARAM]
			-- Call parameters

	extract_service_name: STRING is
			-- Extract the service name from the call's 'method_name'. The 'method_name'
			-- should be in the form 'service.action', where 'service' is the service name.
			-- If a '.' does not exist in the 'method_name' then the service name is returned
			-- as an empty string.
		require
			method_name_exists: method_name /= Void
		local
			i: INTEGER
		do
			i := method_name.index_of ('.', 1)
			if i = 0 or (i - 1) <= 0 then
				Result := ""
			else
				Result := method_name.substring (1, i - 1)
			end
		ensure
			empty_service_name_if_no_dot: method_name.index_of ('.', 1) = 0 implies Result.is_equal ("")
		end
	
	extract_action: STRING is
			-- Extract the service name from the call's 'method_name'. The 'method_name'
			-- should be in the form 'service.action', where 'action' is the action to be invoked.
			-- If a '.' does not exist in the 'method_name' then the action is returned
			-- as an empty string.
		require
			method_name_exists: method_name /= Void
		local
			i: INTEGER
		do
			i := method_name.index_of ('.', 1)
			if i = 0 or (i + 1) >= method_name.count then
				Result := ""
			else
				Result := method_name.substring (i + 1, method_name.count)
			end		
		ensure
			empty_action_if_no_dot: method_name.index_of ('.', 1) = 0 implies Result.is_equal ("")	
		end	
		
	extract_parameters: TUPLE is
			-- Convert params to a tuple suitable for passing to an agent.
		require
			params_exists: params /= Void
		local
			c: DS_LINKED_LIST_CURSOR [XRPC_PARAM]
			i: INTEGER
		do
			create Result.make
			if not params.is_empty then				
				Result.resize (1, params.count)
				from
					c := params.new_cursor
					c.start
					i := 1
				until
					c.off
				loop
					Result.force (c.item.value.as_object, i)
					c.forth
					i := i + 1
				end
			end
		ensure
			param_tuple_exists: Result /= Void
			valid_number_of_params: Result.count = params.count
		end
		
feature -- Status setting

	set_method_name (new_name: STRING) is
			-- Set method to call to 'new_name'
		require
			new_name_exists: new_name /= Void
		do
			method_name := new_name
		end

	add_param (new_param: XRPC_PARAM) is
			-- Add 'new_param' to the list of parameters to send
			-- with this call.
		require
			new_param_exists: new_param /= Void
		do
			params.force_last (new_param)
		end
	
feature -- Marshalling

	marshall: STRING is
			-- Serialize this call to XML format
		local
			c: DS_LINKED_LIST_CURSOR [XRPC_PARAM]
		do
			create Result.make (300)
			Result.append ("<?xml version=%"1.0%"?><methodCall><methodName>")
			Result.append (method_name)
			Result.append ("</methodName>")
			if not params.is_empty then
				Result.append ("<params>")
				from
					c := params.new_cursor
					c.start
				until
					c.off
				loop
					Result.append (c.item.marshall)
					c.forth
				end
				Result.append ("</params>")
			end
			Result.append ("</methodCall>")
		end
	
invariant
	
	method_name_set: unmarshall_ok implies method_name /= Void
	params_exists: unmarshall_ok implies params /= Void
	
end -- class XRPC_CALL
