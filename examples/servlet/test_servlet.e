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
			send_basic_html (req, resp)
		end
	
	do_post (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
			-- Process GET request
		do
			do_get (req, resp)
		end
		
feature {NONE} -- Implementation

	send_basic_html (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
		local
			parameter_names: DS_LINEAR [STRING]
			header_names: DS_LINEAR [STRING]
		do
			resp.send ("<html><head><title>Test Servlet</title></head>%R%N")
			resp.send ("<body><h1>This is a test.</h1>%R%N")
			resp.send ("<p>Visits = " + visit_count.out + "</p>%R%N")
			-- display all parameters
			resp.send ("<h2>Parameters</h2>%R%N")
			from
				parameter_names := req.get_parameter_names
				parameter_names.start
			until
				parameter_names.off
			loop
				resp.send (parameter_names.item_for_iteration + " = " 
					+ quoted_eiffel_string_out (req.get_parameter (parameter_names.item_for_iteration)) + "<br>%R%N")
				parameter_names.forth
			end				
			-- display all variables
			resp.send ("<h2>Headers</h2>%R%N")
			from
				header_names := req.get_header_names
				header_names.start
			until
				header_names.off
			loop
				resp.send (header_names.item_for_iteration + " = " 
					+ quoted_eiffel_string_out (req.get_header (header_names.item_for_iteration)) + "<br>%R%N")
				header_names.forth
			end			
			resp.send ("</body></html>%R%N")	
		end	

	visit_count: INTEGER
		
end -- class TEST_SERVLET
