indexing
	description: "Objects that represent HTTP request information."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTP_SERVLET_REQUEST

inherit
	SERVLET_REQUEST

feature -- Access

	get_header (name: STRING): STRING is
			-- Get the value of the specified request header.
		require
			name_exists: name /= Void
			has_header: has_header (name)
		deferred
		ensure
			result_exists: Result /= Void
		end

	get_headers (name: STRING): DS_LINEAR [STRING] is
			-- Get all values of the specified request header. If the
			-- header has comma-separated values they are separated and added to the
			-- result. If only one value exists, it is added as the sole entry in the
			-- list.
		require
			name_exists: name /= Void
			has_header: has_header (name)
		deferred
		ensure
			result_exists: Result /= Void
		end
	
	get_header_names: DS_LINEAR [STRING] is
			-- Get all header names.
		deferred
		ensure
			result_exists: Result /= Void
		end

feature -- Status report

	has_header (name: STRING): BOOLEAN is
			-- Does this request contain a header named 'name'?
		require
			name_exists: name /= Void
		deferred
		end
	
	auth_type: STRING is
			-- The name of the authentication scheme used to protect the servlet,
			-- for example, "BASIC" or "SSL" or Void if the servlet was not protected.
		deferred
		end
	
	cookies: ARRAY [COOKIE] is
			-- Cookies sent with this request.
		deferred
		ensure
			result_exists: cookies /= Void
		end
	
	method: STRING is
			-- The name of the HTTP method with which this request was made, for
			-- example, GET, POST, or HEAD.
		deferred
		end
	
	path_info: STRING is
			-- Any extra path information associated with the URL the client sent
			-- when it made the request.
		deferred
		end
	
	path_translated: STRING is
			-- Any extra path information after the servlet name but before
			-- the query string translated to a real path.
		deferred
		end
	
	query_string: STRING is
			-- The query string that is contained in the request URL after the path.
			-- Returns Void if no query string is sent.
		deferred
		end
	
	remote_user: STRING is
			-- The login of the user making this request, if the user has been
			-- authenticated, or Void if the user has not been authenticated.
		deferred
		end
	
	servlet_path: STRING is
			-- The part of this request's URL that calls the servlet. This includes
			-- either the servlet name or a path to the servlet, but does not include
			-- any extra path information or a query string.
		deferred	
		end

end -- class HTTP_SERVLET_REQUEST
