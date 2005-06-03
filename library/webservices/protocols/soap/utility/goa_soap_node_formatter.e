indexing
	description: "Objects that serialise SOAP block nodes with optional attributes."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_SOAP_NODE_FORMATTER

inherit
	
	XM_FORMATTER
		export
			{NONE} all
			{ANY} make, wipe_out, set_output
		redefine
			process_document
		end

create
	
	make
	

feature -- Tree processor routines

	process_document (a_document: XM_DOCUMENT) is
			-- Process document using xmlns generator and pretty print filters.
		local
			pretty_print: XM_PRETTY_PRINT_FILTER
		do
			create pretty_print.make_null
			pretty_print.set_output_stream (last_output)
			a_document.process_to_events (pretty_print)
		end

end -- class GOA_SOAP_NODE_FORMATTER
