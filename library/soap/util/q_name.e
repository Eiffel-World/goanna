indexing
	description: "Objects that represent a fully qualified name."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	Q_NAME

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

	make_from_node (node: DOM_NODE) is
			-- Initialise a new fully qualified name from the namespace
			-- and localname of 'node'.
		require
			node_exists: node /= Void
			node_qualified: node.namespace_uri /= Void and node.local_name /= Void
		do
			namespace := node.namespace_uri.out
			local_name := node.local_name.out
		end

	make_from_qname (qname: STRING) is
			-- Initialise a new fully qualified name from
			-- separated 'qname'. Separator is ':'.
		require
			qname_exists: qname /= Void
			qname_has_separator: qname.occurrences (':') = 1
		local
			index: INTEGER
		do
			index := qname.index_of (':', 1)
			namespace := qname.substring (1, index - 1)
			local_name := qname.substring (index + 1, qname.count)
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
				Result := namespace + ":" + local_name
			end
		ensure then
			out_exists: Result /= Void
		end
	
	matches (node: DOM_NODE): BOOLEAN is
			-- Does this qualified name match the qualified name of 'node'?
		require
			node_exists: node /= Void
		do
			Result := node /= Void and then is_equal (create {Q_NAME}.make_from_node (node))
		end

invariant
	
	namespace_exists: namespace /= Void
	local_name_exists: local_name /= Void
	
end -- class Q_NAME
