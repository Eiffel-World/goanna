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
		local
			header_names: LINEAR [STRING]
		do
			visit_count := visit_count + 1
			--resp.send_error (Sc_not_implemented)
			--resp.send_redirect ("http://slashdot.org")
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
			
			-- test XMLE generated document
			create document.make
		end
	
	do_post (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
			-- Process GET request
		do
			do_get (req, resp)
		end
		
feature {NONE} -- Implementation

	document: ORDER_XMLE
	
	visit_count: INTEGER
	
	dom_nodes_refs: XMLE_DOM_STORAGE_REFS
	
end -- class TEST_SERVLET
