indexing
	description: "Objects that represent a fully qualified name."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Colin Adams <colin@colina.demon.co.uk>"
	copyright: "Copyright (c) 2005 Colin Adams and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class GOA_EXPANDED_QNAME

inherit
	
	HASHABLE
		redefine
			out, is_equal
		end

create
	make, make_from_node, make_from_qname

feature -- Initialization

	make (new_namespace, new_local_name: STRING) is
			-- Initialise a new fully qualified name with 'namespace'
			-- and 'localName
		require
			namespace_exists: new_namespace /= Void
			local_name_exists: new_local_name /= Void
		do
			namespace := new_namespace
			local_name := new_local_name
		end

	make_from_node (a_node: XM_NAMED_NODE) is
			-- Initialise a new fully qualified name from the namespace
			-- and localname of 'node'.
		require
			node_exists: a_node /= Void
		do
			namespace := a_node.namespace.uri
			local_name := a_node.name
		end

	make_from_qname (an_expanded_qname: STRING) is
			-- Initialise a new fully qualified name from `an_expanded_qname'
		require
			qname_exists: an_expanded_qname /= Void
		local
			an_index: INTEGER
		do
			if an_expanded_name.item (1).is_equal (Ns_openening_brace.item (1)) then
				an_index := an_expanded_name.index_of (Ns_closing_brace.item (1), 2)
				check
					closing_brace_found: an_index > 1
					local_name_present: an_expanded_name.count > an_index
					-- definition of expanded name
				end
				local_name := an_expanded_name.substring (an_index + 1, an_expanded_name.count)
				namespace := an_expanded_name.substring (2, an_index - 1)
			else
				local_name := an_expanded_qname
				namespace := ""
			end
		end
		
feature -- Access

	namespace: STRING
			-- Namespace component of this qualified name
			
	local_name: STRING
			-- Local part of this qualified name

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := (namespace.hash_code.out + "_" + local_name.hash_code.out).hash_code
		end
		
feature -- Element change

	set_namespace (new_namespace: STRING) is
			-- Set 'namespace' to 'new_namespace'
		require
			namespace_exists: new_namespace /= Void
		do
			namespace := new_namespace
		ensure
			namespace_set: namespace = new_namespace
		end
		
	set_local_name (new_local_name: STRING) is
			-- Set 'local_name' to 'new_local_name'
		require
			local_name_exists: new_local_name /= Void
		do
			local_name := new_local_name
		ensure
			local_name_set: local_name = new_local_name
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
            Result := other /= Void 
            	and then namespace.is_equal (other.namespace)
            	and then local_name.is_equal (other.local_name)
		end
		
feature -- Transformation

	out: STRING is
			-- String representation of this qualified name
		do
			if namespace.is_empty then
				Result := local_name
			else
				Result := Ns_openening_brace + namespace + Ns_closing_brace.item + local_name
			end
		ensure then
			out_exists: Result /= Void
		end
	
	matches (a_node: XM_NAMED_NODE): BOOLEAN is
			-- Does this qualified name match the qualified name of 'node'?
		require
			node_exists: a_node /= Void
		local
			a_qname: GOA_EXPANDED_QNAME
		do
			create a_qname.make_from_node (a_node)
			Result := is_equal (a_qname)
		end

invariant
	
	namespace_exists: namespace /= Void
	local_name_exists: local_name /= Void
	
end -- class GOA_EXPANDED_QNAME
