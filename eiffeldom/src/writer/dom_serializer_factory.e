indexing
	description: "Objects that create appropriate DOM serializer objects for documents."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	DOM_SERIALIZER_FACTORY

feature -- Access

	serializer_for_document (doc: DOM_DOCUMENT): DOM_SERIALIZER is
			-- Create a serializer for 'doc'
		require
			document_exists: doc /= Void			
		do
			if is_document_xml (doc) then
				create {DOM_XML_SERIALIZER} Result.make
			else
				-- TODO: handle other document types
			end
		ensure
			result_exists: Result /= Void
		end
	
feature {NONE} -- Implementation

	is_document_xml (doc: DOM_DOCUMENT): BOOLEAN is
			-- Is 'doc' an XML document?
		require
			document_exists: doc /= Void			
		do
			-- TODO: handle other document types
			Result := True
		end
	
end -- class DOM_SERIALIZER_FACTORY
