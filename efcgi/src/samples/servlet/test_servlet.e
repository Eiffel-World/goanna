indexing
	description: "A test servlet"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SERVLET

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
			visit_count := visit_count + 1
			--send_basic_html (req, resp)
			send_xmle_document (req, resp)
		end
	
	do_post (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
			-- Process GET request
		do
			do_get (req, resp)
		end
		
feature {NONE} -- Implementation

	send_basic_html (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
		local
			header_names: LINEAR [STRING]
		do
			resp.send ("<html><head><title>Test Servlet</title></head>%R%N")
			resp.send ("<body><h1>This is a test.</h1>%R%N")
			resp.send ("<p>Visits = " + visit_count.out + "</p>%R%N")
			-- display all variables
			from
				header_names := req.get_header_names
				header_names.start
			until
				header_names.off
			loop
				resp.send (header_names.item + " = " 
					+ quoted_eiffel_string_out (req.get_header (header_names.item)) + "<br>%R%N")
				header_names.forth
			end			
			resp.send ("</body></html>%R%N")	
		end
	
	send_xmle_document (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
		do
			-- test XMLE generated document
			resp.set_content_type ("text/xml")
			create document.make
			resp.send (document.to_document)
		end
		
	document: ORDER_XMLE
	
	visit_count: INTEGER
	
	dom_nodes_refs: XMLE_DOM_STORAGE_REFS
	
end -- class TEST_SERVLET
