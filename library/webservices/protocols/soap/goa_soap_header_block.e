indexing
	description: "Objects that represent a SOAP header block"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class GOA_SOAP_HEADER_BLOCK

inherit

	GOA_SOAP_BLOCK
		redefine
			is_encoding_style_permitted
		end

create

	make_last
	
feature -- Access
			
	role: UT_URI
			-- Role for this header (i.e. nodes at which this header is targetted). Void if unspecified 
			-- (ie.implicitly targeted at the ultimate SOAP receiver)
			
	must_understand: BOOLEAN_REF
			-- Must understand flag. Void if unspecified.

	relay:  BOOLEAN_REF
			-- Relay flag. Void if unspecified.
	
	is_encoding_style_permitted: BOOLEAN is
			-- Is `encoding_style' permitted to be non-Void?
		do
			if STRING_.same_string (node.name, Upgrade_element_name) and then
				node.has_namespace and then STRING_.same_string (node.namespace.uri, Ns_name_env) then
				Result := False
			else
				Result := Precursor
			end
		end

feature -- Status setting
	
	set_role (a_role: like role) is
			-- Set `role' to `a_role'
		require
			role_exists: a_role /= Void
		local
			a_uri: STRING
			a_namespace: XM_NAMESPACE
		do
			role := a_role
			if node.has_attribute_by_qualified_name (Ns_name_env, Role_attr) then
				node.remove_attribute_by_qualified_name (Ns_name_env, Role_attr)
			end
			a_uri := a_role.full_reference
			if not STRING_.same_string (a_uri, Role_ultimate_receiver) then
				create a_namespace.make (Ns_prefix_env, Ns_name_env)
				node.add_attribute (Role_attr, a_namespace, a_uri)
			end
		ensure
			role_set: role = a_role
		end
	
	set_must_understand (a_flag: BOOLEAN) is
			-- Set `must_understand' to value of `a_flag'.
			-- Do not call this method to leave unspecified.
		local
			a_namespace: XM_NAMESPACE
		do
			create must_understand
			must_understand.set_item (a_flag)
			if node.has_attribute_by_qualified_name (Ns_name_env, Must_understand_attr) then
				node.remove_attribute_by_qualified_name (Ns_name_env, Must_understand_attr)
			end
			if must_understand.item then
				create a_namespace.make (Ns_prefix_env, Ns_name_env)
				node.add_attribute (Must_understand_attr, a_namespace, "true")
			end
		end

	set_relay (a_flag: BOOLEAN) is
			-- Set `relay' to value of `a_flag'.
			-- Do not call this method to leave unspecified.
		local
			a_namespace: XM_NAMESPACE
		do
			create relay
			relay.set_item (a_flag)
			if node.has_attribute_by_qualified_name (Ns_name_env, Relay_attr) then
				node.remove_attribute_by_qualified_name (Ns_name_env, Relay_attr)
			end
			if relay.item then
				create a_namespace.make (Ns_prefix_env, Ns_name_env)
				node.add_attribute (Relay_attr, a_namespace, "true")
			end
		end

feature {GOA_SOAP_NODE_FORMATTER} -- Implementation

	must_understand_attribute: STRING is
			-- Must understand attribute for insertion in marshall strings;
			-- Created string is prefixed with a single space.
		do
			create Result.make (40)
			if must_understand /= Void and then must_understand.item then
				Result.append_string (Space_s)
				Result.append_string (Ns_prefix_env)
				Result.append_string (Prefix_separator)
				Result.append_string (Must_understand_attr)
				Result.append (Eq_s)
				Result.append (Quot_s)
				Result.append (True_value)
				Result.append (Quot_s)
			end
		ensure
			Result_not_void: Result /= Void
		end

	relay_attribute: STRING is
			-- Relay attribute for insertion in marshall strings;
			-- Created string is prefixed with a single space.
		do
			create Result.make (40)
			if relay /= Void and then relay.item then
				Result.append_string (Space_s)
				Result.append_string (Ns_prefix_env)
				Result.append_string (Prefix_separator)
				Result.append_string (Relay_attr)
				Result.append (Eq_s)
				Result.append (Quot_s)
				Result.append (True_value)
				Result.append (Quot_s)
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	role_attribute: STRING is
			-- Role attribute for insertion in marshall strings;
			-- Created string is prefixed with a single space.
		do
			create Result.make (40)
			if role /= Void then
				Result.append_string (Space_s)
				Result.append_string (Ns_prefix_env)
				Result.append_string (Prefix_separator)
				Result.append_string (Role_attr)
				Result.append (Eq_s)
				Result.append (Quot_s)
				Result.append (role.full_reference) -- TODO
				Result.append (Quot_s)
			end
		ensure
			Result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

--	unmarshall_role_attribute (a_node: XM_ELEMENT; an_identifying_uri, a_role_uri: UT_URI) is
--				-- Search for optional role attribute, unmarshall and set
--				-- `role' if found. Notify of unmarshalling error by setting
--				-- `unmarshall_ok'.
--				--| role attribute is explicitly encoded as an XMLSchema anyURI.
--			require
--				node_exists: a_node /= Void
--				node_uri_not_void: a_role_uri /= Void and then not STRING_.same_string (a_role_uri.full_reference, Role_ultimate_receiver) implies an_identifying_uri /= Void
--			local
--				a_str: STRING
--				a_uri: UT_URI
--				an_attr: XM_ATTRIBUTE
--			do
--				if a_node.has_attribute_by_qualified_name (Ns_name_env, Role_attr) then
--					an_attr := node.attribute_by_qualified_name (Ns_name_env, Role_attr)
--					value_factory.unmarshall_value (an_attr.value, Ns_name_xs, Xsd_anyuri)
--					if not value_factory.unmarshall_ok then
--						unmarshall_ok := False; unmarshall_fault := value_factory.unmarshall_fault
--					else
--						a_str ?= value_factory.last_value.as_object
--						if a_str /= Void and then not a_str.is_empty and then not Url_encoding.has_excluded_characters (a_str) then
--							create a_uri.make (a_str)
--							set_role (a_uri)
--						else
--							set_unmarshall_fault (Sender_fault, "Env:role is not an xs:anyURI", an_identifying_uri, a_role_uri)
--						end			
--					end
--				end
--			end
	
--		unmarshall_must_understand_attribute (a_node: XM_ELEMENT; an_identifying_uri, a_role_uri: UT_URI) is
--				-- Search for optional mustUnderstand attribute, unmarshall and set
--				-- `must_understand' if found. Notify of unmarshalling error by setting
--				-- `unmarshall_ok'.
--				--| mustUnderstand attribute is explicitly encoded as an XMLSchema boolean.
--			require
--				node_exists: a_node /= Void
--				node_uri_not_void: a_role_uri /= Void and then not STRING_.same_string (a_role_uri.full_reference, Role_ultimate_receiver) implies an_identifying_uri /= Void
--			local
--				a_bool: BOOLEAN_REF
--				an_attr: XM_ATTRIBUTE
--			do
--				if a_node.has_attribute_by_qualified_name (Ns_name_env, Must_understand_attr) then
	
--				an_attr := node.attribute_by_qualified_name (Ns_name_env, Must_understand_attr)
--					value_factory.unmarshall_value (an_attr.value, Ns_name_xs, Xsd_boolean)
--					if not value_factory.unmarshall_ok then
--						unmarshall_ok := False; unmarshall_fault := value_factory.unmarshall_fault
--					else
--						a_bool ?= value_factory.last_value.as_object
--						set_must_understand (a_bool.item)
--					end
--				end
--			end
		
--		unmarshall_relay_attribute (a_node: XM_ELEMENT; an_identifying_uri, a_role_uri: UT_URI) is
--				-- Search for optional relay attribute, unmarshall and set
--				-- `relay' if found. Notify of unmarshalling error by setting
--				-- `unmarshall_ok'.
--				--| relay attribute is explicitly encoded as an XMLSchema boolean.
--			require
--				node_exists: a_node /= Void
--				node_uri_not_void: a_role_uri /= Void and then not STRING_.same_string (a_role_uri.full_reference, Role_ultimate_receiver) implies an_identifying_uri /= Void
--			local
--				a_bool: BOOLEAN_REF
--				an_attr: XM_ATTRIBUTE
--			do
--				if a_node.has_attribute_by_qualified_name (Ns_name_env, Relay_attr) then
--					an_attr := node.attribute_by_qualified_name (Ns_name_env, Relay_attr)
--					value_factory.unmarshall_value (an_attr.value, Ns_name_xs, Xsd_boolean)
--					if not value_factory.unmarshall_ok then
--						unmarshall_ok := False; unmarshall_fault := value_factory.unmarshall_fault
--					else
--						a_bool ?= value_factory.last_value.as_object
	--					set_relay (a_bool.item)
--					end
--				end
	
--		end
	
end -- class GOA_SOAP_HEADER_BLOCK
