indexing
	description: "Servlet for testing XMLE generated documents"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class XMLE_TEST_SERVLET

inherit

	HTTP_SERVLET
		redefine
			do_get, do_post
		end

	UT_STRING_FORMATTER
		export
			{NONE} all
		end
		
creation

	init
	
feature -- Basic operations

	do_get (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process GET request
		do
			send_xmle_document (req, resp)
		end
	
	do_post (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process GET request
		do
			do_get (req, resp)
		end
		
feature {NONE} -- Implementation
	
	send_xmle_document (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
		local
			element: DOM_ELEMENT
			str, str2: DOM_STRING
			doc: STRING
		do
			-- test XMLE generated document
			resp.set_content_type ("text/xml")
			create document.make
			-- modify a few fields
			element := document.get_node_customer1
			create str.make_from_string ("newAttribute")
			create str2.make_from_string ("newValue")
			element.set_attribute (str, str2)
			doc := document.to_document
			resp.set_content_length (doc.count)
			resp.send (doc)
		end
		
	document: ORDER_XMLE
	
	dom_nodes_refs: XMLE_DOM_STORAGE_REFS
	
end -- class XMLE_TEST_SERVLET
