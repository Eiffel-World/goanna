indexing
	description: "Node iterator implementation."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Document Object Model (DOM) Traversal Impl"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	DOM_NODE_ITERATOR_IMPL

inherit

	DOM_NODE_ITERATOR

create
	make

feature -- Initialization

	make (doc: DOM_DOCUMENT_IMPL; root_node: DOM_NODE; show_options: INTEGER; 
		node_filter: DOM_NODE_FILTER; expand_entity_references_flag: BOOLEAN) is
				-- Create a new node iterator.
			require
				doc_exists: doc /= Void
				root_exists: root_node /= Void
				positive_show_options: show_options >= 0			
			do
				attached := True
				forward := True
				what_to_show := show_options
				filter := node_filter
				expand_entity_references := expand_entity_references_flag
				document := doc
				root := root_node
			end
		
feature -- Access

	attached: BOOLEAN
			-- Is the iterator attached to the underlying subtree?
	
	what_to_show: INTEGER
			-- Which node types are presented via the iterator. The available set of constants
			-- is defined by the DOM_NODE_FILTER_TYPES class.
	
	filter: DOM_NODE_FILTER
			-- The filter used to screen nodes.
	
	expand_entity_references: BOOLEAN
			-- Are children of entity reference nodes visible to the iterator? If false, they will
			-- be skipped over.
		    -- To produce a view of the document that has entity references 
     		-- expanded and does not expose the entity reference node itself, use the 
     		-- 'what_to_show' flags to hide the entity reference node and set 
    		-- 'expand_entity_references' to true when creating the iterator. To produce 
     		-- a view of the document that has entity reference nodes but no entity 
     		-- expansion, use the 'what_to_show' flags to show the entity reference node 
     		-- and set 'expand_entity_references' to false.
	
	next_node: DOM_NODE is
			-- Returns the next node in the set and advances the position of the 
     		-- iterator in the set. After a DOM_NODE_ITERATOR is created, the first call 
     						-- to 'next_node' returns the first node in the set.
		do
		end
	
	previous_node: DOM_NODE is
			-- Returns the previous node in the set and moves the position of the 
     		-- iterator backwards in the set.
		do
		end
	
feature -- Status setting

	detach is
			-- Detaches the iterator from the set which it iterated over, releasing 
     		-- any computational resources. 
		do
		end
	
feature

	document: DOM_DOCUMENT_IMPL
		-- The document whos nodes will be iterated
	
	root: DOM_NODE
		-- The root node from which to start
	
	current_node: DOM_NODE
		-- The last node returned.
		
	forward: BOOLEAN
		-- The direction of the iterator on the current_node.
		
	
end -- class DOM_NODE_ITERATOR_IMPL
