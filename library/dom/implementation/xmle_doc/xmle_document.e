indexing
	description: "Objects that hold and provide access to a DOM document generated by the XMLE compiler"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XMLE DOM Extensions"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	XMLE_DOCUMENT

feature  -- Initialisation

	make is
		do
			retrieve_document
		end

feature {NONE} -- Implementation

	retrieve_document is
		require
			bdom_file_name_exists: bdom_file_name /= Void
		local
			bdom_file: IO_MEDIUM
		do
			create {RAW_FILE} bdom_file.make_open_read (bdom_file_name)
			wrapper ?= bdom_file.retrieved
		ensure
			wrapper_retrieved: wrapper /= Void
		end

feature -- Access

	wrapper: XMLE_DOCUMENT_WRAPPER
			-- The storage wrapper holding the document.

	document: DOM_DOCUMENT is
			-- The actual document held by this wrapper.
		do
			Result := wrapper.document
		end

	bdom_file_name: STRING is
			-- Name of binary file holding the document object structure
		deferred
		end

feature -- Basic Operations

	to_document: STRING is
			-- Generate string representation of this document suitable for sending.
		require
			document_loaded: document /= Void
		local
			serializer: DOM_SERIALIZER
			stream: IO_STRING
		do
			serializer := serializer_factory.serializer_for_document (document)
			create stream.make (4096)
			serializer.set_output (stream)
			serializer.serialize (document)
			Result ?= stream
		ensure
			result_exists: Result /= Void
		end
		
feature {NONE} -- Implementation

	serializer_factory: DOM_SERIALIZER_FACTORY is
			-- Factory for creating serializer objects
		once
			create Result
		end
	
end -- class XMLE_DOCUMENT