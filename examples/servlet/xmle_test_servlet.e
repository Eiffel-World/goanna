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
		
create

	init
	
feature -- Basic operations

	do_get (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
			-- Process GET request
		do
			send_xmle_document (req, resp)
		end
	
	do_post (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
			-- Process GET request
		do
			do_get (req, resp)
		end
		
feature {NONE} -- Implementation
	
	send_xmle_document (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
		do
			-- test XMLE generated document
			resp.set_content_type ("text/xml")
			create document.make
			resp.send (document.to_document)
		end
		
	document: ORDER_XMLE
	
	dom_nodes_refs: XMLE_DOM_STORAGE_REFS
	
end -- class XMLE_TEST_SERVLET
