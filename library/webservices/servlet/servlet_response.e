indexing
	description: "Objects that assist a servlet in sending a response to a client."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	SERVLET_RESPONSE

feature -- Status report

	buffer_size: INTEGER is
			-- Actual size of response buffer.
		deferred
		end

	is_committed: BOOLEAN is
			-- Has the response been committed? A committed response has already
			-- had its status code and headers written.
		deferred
		end
		
feature -- Status setting

	set_content_length (length: INTEGER) is
			-- Set the length of the content body in the response.
		require
			positive_length: length >= 0
		deferred
		end
	
	set_content_type (type: STRING) is
			-- Set hte content type of the response being sent to the client.
			-- The content type may include the type of character encoding used, for
			-- example, 'text/html; charset=ISO-885904'
		require
			type_exists: type /= Void
		deferred
		end
	
	set_buffer_size (size: INTEGER) is
			-- Set the preferred buffer size for the body of the response.
		deferred
		end
	
feature -- Basic operations

	flush_buffer is
			-- Force any content in the buffer to be written to the client. A call
			-- to this method automatically commits the response, meaning the status
			-- code and headers will be written.
		deferred
		ensure
			committed: is_committed
		end

	reset is
			-- Clear any data that exists in the buffer as well as the status code
			-- and headers.
		require
			not_committed: not is_committed
		deferred
		ensure
			not_committed: not is_committed
		end
		
end -- class SERVLET_RESPONSE
