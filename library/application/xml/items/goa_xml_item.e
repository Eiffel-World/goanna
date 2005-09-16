indexing
	description: "Items that may be added to a GOA_XML_DOCUMENT"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	
	GOA_XML_ITEM
	
feature {GOA_XML_DOCUMENT}
	
	add_to_document (the_document: GOA_XML_DOCUMENT) is
			-- Add an xml representation of this item to the_documnet
		require
			valid_the_document: the_document /= Void
			ok_to_add: ok_to_add (the_document)
		deferred
		end

feature -- Queries

	ok_to_add (the_document: GOA_XML_DOCUMENT): BOOLEAN is
			-- Is it OK to add this item to the_document
		require
			valid_the_document: the_document /= Void
		deferred
		end

end -- class GOA_XML_ITEM
