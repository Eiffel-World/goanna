indexing
	description: "Objects that represent a FastCGI standalone application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

deferred class GOA_FAST_CGI_APP

inherit

	GOA_FAST_CGI
		export
			{NONE} all
		end

	KL_SHARED_EXCEPTIONS

feature -- Basic operations

	run is
			-- Read requests as they are received and process each by calling
			-- process_request
		do
			from
			until
				accept < 0
			loop
				process_request
			end
		rescue
			if not field_exception then
				error (Servlet_app_log_category, "Uncaught exception, code: " + Exceptions.exception.out + ", retry not requested, so exiting...")
			else
				retry
			end
		end

	process_request is
			-- Process a request.
		deferred
		end


	field_exception: BOOLEAN is
			-- Should we attempt to retry?
		require
			True
		deferred
		end

end -- class GOA_FAST_CGI_APP
