indexing
	description: "Snoop servlet that outputs request information."
	note: "Includes debug statements labeled 'snoop' to output to stdout"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SNOOP_SERVLET

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
		local
			response: STRING
		do
			create response.make (1024)
			debug ("snoop")
				print ("Snoop Servlet%R%N")
			end
			response.append ("<html><head><title>Snoop Servlet</title></head>%R%N")
			response.append ("<h1>Snoop Servlet</h1>")
			response.append (request_html (req, resp))
			response.append ("</body></html>%R%N")	
			resp.set_content_length (response.count)
			resp.send (response)
		end
	
	do_post (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process GET request
		do
			do_get (req, resp)
		end
		
feature {NONE} -- Implementation

	request_html (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE): STRING is
		local
			parameter_names: DS_LINEAR [STRING]
			header_names: DS_LINEAR [STRING]
			line: STRING
		do
			create Result.make (255)
			-- display all variables
			Result.append ("<h2>Headers</h2>%R%N")
			debug ("snoop")
				print ("Request Headers:%R%N")
			end
			from
				header_names := req.get_header_names
				header_names.start
			until
				header_names.off
			loop
				line := header_names.item_for_iteration + " = " 
					+ quoted_eiffel_string_out (req.get_header (header_names.item_for_iteration))
				debug ("snoop")
					print ("%T" + line + "%R%N")
				end
				Result.append (line + "<br>%R%N")
				header_names.forth
			end	
			-- display all content
			if not req.content.is_empty then
				debug ("snoop")
					print ("Content Data:%R%N")
					print ("%T" + quoted_eiffel_string_out (req.content) + "%R%N")
				end
				Result.append ("<h2>Content Data</h2>%R%N")
				Result.append (quoted_eiffel_string_out (req.content))
			end
			-- display all parameters
			Result.append ("<h2>Parameters</h2>%R%N")
			debug ("snoop")
				print ("Parameters:%R%N")
			end
			from
				parameter_names := req.get_parameter_names
				parameter_names.start
			until
				parameter_names.off
			loop
				line := parameter_names.item_for_iteration + " = " 
					+ quoted_eiffel_string_out (req.get_parameter (parameter_names.item_for_iteration))
				debug ("snoop")
					print ("%T" + line + "%R%N")
				end
				Result.append (line + "<br>%R%N")
				parameter_names.forth
			end				

		end	
		
end -- class SNOOP_SERVLET
