indexing
	description: "Objects that hold a DOM document and provide storable and access capabilities"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

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
			collect_id_elements
		end

feature -- Access

	document: DOM_DOCUMENT
			-- The document held by this wrapper.

	id_elements: HASH_TABLE [DOM_NODE, STRING]
			-- Table of elements indexed by 'id'. 

	get_element_by_id (id: STRING): DOM_NODE is
			-- Retrieve a reference to an element with the given 'id'.
		do
			Result := id_elements.item (id)
		end

feature {NONE} -- Implementation

	collect_id_elements is
			-- Collect all elements in 'document' with an 'id' attribute and
			-- store a reference to the element in the 'id_elements' table.
		do
			create id_elements.make (10) -- TODO: create to required size to minimize memory
		end
		
invariant

	document_exists: document /= Void
	id_element_table_exists: id_elements /= Void

end -- class XMLE_DOCUMENT_WRAPPER
