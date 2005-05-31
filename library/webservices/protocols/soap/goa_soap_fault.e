indexing
	description: "Objects that represent a SOAP fault."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_SOAP_FAULT

inherit

	GOA_SOAP_BLOCK
		redefine
			is_encoding_style_permitted
		end

	XM_UNICODE_CHARACTERS_1_0
		undefine
			copy, is_equal
		end
	
	UC_SHARED_STRING_EQUALITY_TESTER
		undefine
			copy, is_equal
		end

creation

	make_last, construct

feature -- Initialization

	construct (a_fault_code: INTEGER; a_reason, a_language: STRING; a_node_uri, a_role_uri: UT_URI; a_detail: like detail) is
			-- Initialise new fault.
		require
			valid_fault_code: is_valid_fault_code (a_fault_code)
			reason_exists: a_reason /= Void
			language_exists: a_language /= Void
		do
			-- TODO - need to create a node, and then unmarshall it
		end

	make_core is
			-- Establish invariant.
		do
			create sub_codes.make_default
			sub_codes.set_equality_tester (string_equality_tester)
			create reasons.make_with_equality_testers (3, string_equality_tester, string_equality_tester)
			create namespace_bindings.make_with_equality_testers (7, string_equality_tester, string_equality_tester)
		end

--	unmarshall (init_node: XM_ELEMENT; an_identifying_uri, a_role_uri: UT_URI) is
			-- Initialise SOAP fault from XML node.
--		local
--			a_sub_element_count, an_index: INTEGER
--			an_element: XM_ELEMENT
--			node_seen, role_seen, detail_seen: BOOLEAN
--		do
--			make_core
--			unmarshall_ok := True
--			check
--				fault_element: STRING_.same_string (init_node.name, Fault_element_name) and then init_node.has_namespace
--					and then STRING_.same_string (init_node.namespace.uri, Ns_name_env)
--			end
--			unmarshall_encoding_style_attribute (init_node, an_identifying_uri, a_role_uri)
--			if unmarshall_ok then
--				a_sub_element_count := init_node.elements.count
--				if a_sub_element_count < 2 then
--					set_unmarshall_fault (Sender_fault, "Env:Fault does not contain the minimum required elements", an_identifying_uri, a_role_uri)
--				elseif a_sub_element_count > 5 then
--					set_unmarshall_fault (Sender_fault, "Env:Fault contains too many elements", an_identifying_uri, a_role_uri)
--				else
--					an_element := init_node.elements.item (1)
--					if is_valid_element (an_element, Fault_code_element_name) then
--						unmarshall_code (an_element, an_identifying_uri, a_role_uri)
--						if unmarshall_ok then
--							an_element := init_node.elements.item (2)
--							if is_valid_element (an_element, Fault_reason_element_name) then
--								unmarshall_reason (an_element, an_identifying_uri, a_role_uri)
--								if unmarshall_ok then
	--								from
--										an_index := 3
--									until
--										not unmarshall_ok or else an_index > a_sub_element_count
--									loop
--										an_element := init_node.elements.item (an_index)
--										if is_valid_element (an_element, Fault_node_element_name) then
--											if node_seen then
--												set_unmarshall_fault (Sender_fault, "Env:Fault contains more than one env:Node element", an_identifying_uri, a_role_uri)
--											elseif role_seen or else detail_seen then
--												set_unmarshall_fault (Sender_fault, "Env:Fault contains more env:Node element out of order", an_identifying_uri, a_role_uri)
--											else
--												create node_uri.make (an_element.text); node_seen := True
--											end
--										elseif is_valid_element (an_element, Fault_role_element_name) then
--											node_seen := True
--											if role_seen then
--												set_unmarshall_fault (Sender_fault, "Env:Fault contains more than one env:Role element", an_identifying_uri, a_role_uri)
--											elseif detail_seen then
--												set_unmarshall_fault (Sender_fault, "Env:Fault contains more env:Role element out of order", an_identifying_uri, a_role_uri)
--											else
--												create role.make (an_element.text); role_seen := True
--											end
--										elseif is_valid_element (an_element, Fault_detail_element_name) then
--											node_seen := True; role_seen := True
--											if detail_seen then
--												set_unmarshall_fault (Sender_fault, "Env:Fault contains more than one env:Detail element", an_identifying_uri, a_role_uri)
--											else
--												node_seen := True; role_seen := True; detail_seen := True
							-- TODO					create detail.unmarshall (an_element, an_identifying_uri, a_role_uri)
--											end
--										else
--											set_unmarshall_fault (Sender_fault, "Env:Fault contains invalid element", an_identifying_uri, a_role_uri)
--										end
--										an_index := an_index + 1
--									end
--								end
--							else
--								set_unmarshall_fault (Sender_fault, "Env:Fault does not contain env:Reason as second child", an_identifying_uri, a_role_uri)
--							end
--						end
--					else
--						set_unmarshall_fault (Sender_fault, "Env:Fault does not contain env:Code as first child", an_identifying_uri, a_role_uri)
--					end
--				end
--			end
--		end

feature -- Access

	fault_code: INTEGER
			-- Fault code

	sub_codes: DS_ARRAYED_LIST [STRING]
			-- Sub-codes

	reasons: DS_HASH_TABLE [STRING, STRING]
			-- Reasons, indexed by language

	role: UT_URI
			-- Role in which `node_uri' was operating (optional)

	node_uri: UT_URI
			-- Node which generated `Current' (optional)

	detail: GOA_SOAP_BLOCK
			-- Details about `Current' (optional)

	is_encoding_style_permitted: BOOLEAN is
			-- Is `encoding_style' permitted to be non-Void?
		do
			Result := False
		end

feature -- Element change

	set_fault_code (a_fault_code: INTEGER) is
			-- Assign `a_fault_code' to `fault_code'.
		require
			valid_fault_code: is_valid_fault_code (a_fault_code)
		do
			fault_code := a_fault_code
		ensure
			fault_code_assigned: fault_code = a_fault_code
		end

	add_sub_code (a_sub_code: STRING) is
			-- Add `a_sub_code' to `Current'
		require
			sub_code_is_qname: a_sub_code /= Void and then is_qname (a_sub_code)
			-- An additional requirement is that the prefix will be bound. How to check on this?
		do
			sub_codes.force_last (a_sub_code)
		ensure
			one_more: sub_codes.count = old sub_codes.count + 1
			added: STRING_.same_string (a_sub_code, sub_codes.last)
		end

	add_reason (a_reason, a_language: STRING) is
			-- Initialise new fault.
		require
			reason_exists: a_reason /= Void
			language_exists: a_language /= Void
			unique_language: not reasons.has (a_language)
		do
			reasons.force_new (a_reason, a_language)
		ensure
			language_added: reasons.has (a_language)
			reason_added: STRING_.same_string (a_reason, reasons.item (a_language))
		end

	expanded_name_to_qname (an_expanded_name: STRING): STRING is
			-- QName from `an_expanded_name'
		require
			expanded_name_not_empty: an_expanded_name /= Void and then not an_expanded_name.is_empty
			-- TODO: prefix in scope?
		local
			a_namespace_uri, a_local_name: STRING
			an_index: INTEGER
		do
			if an_expanded_name.item (1).is_equal (Ns_openening_brace.item (1)) then
				an_index := an_expanded_name.index_of (Ns_closing_brace.item (1), 2)
				check
					closing_brqace_found: an_index > 1
					local_name_present: an_expanded_name.count > an_index
					-- definition of expanded name
				end
				a_local_name := an_expanded_name.substring (an_index + 1, an_expanded_name.count)
				a_namespace_uri := an_expanded_name.substring (2, an_index - 1)
				check
					namespace_bound: namespace_bindings.has (a_namespace_uri)
				end
				create Result.make_from_string (namespace_bindings.item (a_namespace_uri))
				if not Result.is_empty then Result.append (Prefix_separator) end
				Result.append (a_local_name)
			else
				Result := an_expanded_name
			end
		ensure
			result_not_void: Result /= Void
		end

	prefix_to_namespace (a_prefix: STRING; an_element: XM_ELEMENT): STRING is
			-- Namespace URI for `a_prefix'
		require
			prefix_not_void: a_prefix /= Void
			element_not_void: an_element /= Void
			-- TODO: is_prefix_bound?
		local
			a_list: DS_LINKED_LIST [XM_NAMESPACE]
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NAMESPACE]
			a_parent: XM_ELEMENT
			a_namespace: XM_NAMESPACE
		do
			from
				a_parent := an_element
			until
				Result /= Void or else a_parent = Void
			loop
				a_list := a_parent.namespace_declarations
				from
					a_cursor := a_list.new_cursor; a_cursor.start
				until
					a_cursor.after
				loop
					a_namespace := a_cursor.item
					if STRING_.same_string (a_namespace.ns_prefix, a_prefix) then
						Result := a_namespace.uri
						a_cursor.go_after
					else
						a_cursor.forth
					end
				end
				if Result = Void then a_parent ?= a_parent.parent end
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	namespace_bindings: DS_HASH_TABLE [STRING, STRING]
			-- map of namespace-URIs to prefixes

invariant
	
--	valid_fault_code: unmarshall_ok implies is_valid_fault_code (fault_code)
--	sub_codes_exist: unmarshall_ok implies sub_codes /= Void
--	reasons_exist: unmarshall_ok implies reasons /= Void
--	node_uri_not_void: unmarshall_ok and then role /= Void and then not STRING_.same_string (role.full_reference, Role_ultimate_receiver) implies node_uri /= Void
-- TODO	namespace_bindings_not_void: namespace_bindings /= Void
	
end -- class GOA_SOAP_FAULT
