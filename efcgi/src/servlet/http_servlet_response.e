indexing
	description: "Objects that represent HTTP-specific servlet responses."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_SERVLET_RESPONSE

inherit
	SERVLET_RESPONSE

feature -- Access

	contains_header (name: STRING): BOOLEAN is
			-- Has the header named 'name' already been set?
		require
			name_exists: name /= Void
		deferred			
		end
	
feature -- Measurement

feature -- Status report

feature -- Status setting

	add_cookie (cookie: COOKIE) is
			-- Add 'cookie' to the response. Can be called multiple times
			-- to add more than one cookie.
		require
			cookie_exists: cookie /= Void
		deferred
		end
	
	set_header (name, value: STRING) is
			-- Set a response header with the given name and value. If the
			-- header already exists, the new value overwrites the previous
			-- one.
		require
			name_exists: name /= Void
			value_exists: value /= Void
		deferred
		ensure
			header_set: contains_header (name)
		end
	
	add_header (name, value: STRING) is
			-- Adds a response header with the given naem and value. This
			-- method allows response headers to have multiple values.
		require
			name_exists: name /= Void
			value_exists: value /= Void
		deferred
		ensure
			header_set: contains_header (name)
		end
	
	set_status (sc: INTEGER) is
			-- Set the status code for this response. This method is used to 
			-- set the return status code when there is no error (for example,
			-- for the status codes Sc_ok or Sc_moved_temporarily). If there
			-- is an error, the 'send_error' method should be used instead.
		deferred
		end
	
feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	send_error_msg (sc: INTEGER; msg: STRING) is
			-- Send an error response to the client using the specified
			-- status code and descriptive message. The server generally 
			-- creates the response to look like a normal server error page.
		require
			msg_exists: msg /= Void
			not_committed: not is_committed
		deferred
		ensure
			committed: is_committed
		end
	
	send_error (sc: INTEGER) is
			-- Send an error response to the client using the specified
			-- status code. The server generally creates the response to 
			-- look like a normal server error page.
		require
			not_committed: not is_committed
		deferred
		ensure
			committed: is_committed
		end	
		
	send_redirect (location: STRING) is
			-- Send a temporary redirect response to the client using the
			-- specified redirect location URL.
		require
			location_exists: location /= Void
			not_committed: not is_committed
		deferred
		ensure
			committed: is_committed
		end
	
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class HTTP_SERVLET_RESPONSE
