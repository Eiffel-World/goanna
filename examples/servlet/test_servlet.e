indexing
	description: "Example servlet that outputs hard-coded HTML page."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

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
			set_cookie (req, resp)
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
		
	set_cookie (req: FAST_CGI_SERVLET_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
			-- Set/unset a cookie for this session	
		local
			found: BOOLEAN	
			cookie: COOKIE
		do
			-- check if cookie is set. If so set it, otherwise remove it.
			from
				req.cookies.start
			until
				req.cookies.off
			loop
				found := req.cookies.item_for_iteration.name.is_equal ("servlet_server")
				req.cookies.forth
			end
			create cookie.make ("servlet_server", "testing")
			if found then
				-- remove the cookie by setting its age to zero
				debug ("cookie_parsing")
					print (generator + ".set_cookie removing cookie%R%N")
				end
				cookie.set_max_age (0)	
			else
				debug ("cookie_parsing")
					print (generator + ".set_cookie setting cookie%R%N")
				end
				cookie.set_max_age (5000) -- 5 minutes	
			end
			resp.add_cookie (cookie)	
			-- add a second cookie
			create cookie.make ("GoannaSessionId", "FSDFDSFAFAFEF0011231");
			resp.add_cookie (cookie)
		end
	
end -- class TEST_SERVLET
