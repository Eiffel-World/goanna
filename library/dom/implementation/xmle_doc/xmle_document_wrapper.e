indexing
	description: "Objects that hold a DOM document and provide storable and access capabilities"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XMLE DOM Extensions"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XMLE_DOCUMENT_WRAPPER

inherit

	STORABLE

create
	make

feature -- Initialization

	make (doc: DOM_DOCUMENT) is
			-- Create a wrapper on 'doc'
		require
			doc_exists: doc /= Void
		do
			document := doc
			create id_nodes.make (10)
			collect_id_nodes
		end

feature -- Access

	document: DOM_DOCUMENT
			-- The document held by this wrapper.

	id_nodes: DS_HASH_TABLE [DOM_NODE, STRING]
			-- Table of nodes indexed by 'id'. 

	get_node_by_id (id: STRING): DOM_NODE is
			-- Retrieve a reference to a node with the given 'id'.
		do
			Result := id_nodes.item (id)
		end

feature {NONE} -- Implementation

	Id_attribute_name: STRING is "id"
	
	collect_id_nodes is
			-- Collect all nodes in 'document' with an 'id' attribute and
			-- store a reference to the element in the 'id_elements' table.
		do
			-- check this node for 'id' attribute and store if found
--			if node.has_attributes and node.has_attribute (Id_attribute_name) then
--				id_nodes.force (node, node.get_attribute (Id_attribute_name))
--			end
			
		end
		
invariant

	document_exists: document /= Void
	id_nodes_table_exists: id_nodes /= Void

end -- class XMLE_DOCUMENT_WRAPPER
