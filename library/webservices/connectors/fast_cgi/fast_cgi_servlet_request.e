indexing
	description: "Objects that represent FastCGI servlet request information"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI servlets"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	FAST_CGI_SERVLET_REQUEST

inherit

	CGI_SERVLET_REQUEST
		rename
			make as cgi_servlet_make
		redefine
			has_header, get_header, get_header_names, internal_response
		end
		
creation

	make
	
feature {NONE} -- Initialisation

	make (fcgi_request: FAST_CGI_REQUEST; resp: FAST_CGI_SERVLET_RESPONSE) is
			-- Create a new fast cgi servlet request wrapper for
			-- the request information contained in 'fcgi_request'
		require
			request_exists: fcgi_request /= Void
			response_exists: resp /= Void
		do
			internal_request := fcgi_request
			internal_response := resp
			cgi_servlet_make (internal_response)
			create parameters.make (5)
			parse_parameters
		end
	
feature -- Access

	get_header (name: STRING): STRING is
			-- Get the value of the specified request header.
		do
			Result := clone (internal_request.parameters.item (name))
		end

	get_header_names: DS_LINEAR [STRING] is
			-- Get all header names.
		local
			cursor: DS_HASH_TABLE_CURSOR [STRING, STRING]
			array_list: DS_ARRAYED_LIST [STRING]
		do
			create array_list.make (internal_request.parameters.count)
			cursor := internal_request.parameters.new_cursor
			from
				cursor.start
			until
				cursor.off
			loop
				array_list.force_last (clone (cursor.key))
				cursor.forth
			end
			Result := array_list
		end

feature -- Status report

	has_header (name: STRING): BOOLEAN is
			-- Does this request contain a header named 'name'?
		do
			Result := internal_request.parameters.has (name)
		end
		
feature {NONE} -- Implementation

	internal_request: FAST_CGI_REQUEST
		-- Internal request information and stream functionality.
	
	internal_response: FAST_CGI_SERVLET_RESPONSE
		-- Response object held so that session cookie can be set.

end -- class FAST_CGI_SERVLET_REQUEST
