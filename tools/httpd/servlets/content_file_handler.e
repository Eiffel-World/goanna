indexing
	description: "Generic content file handler"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	CONTENT_FILE_HANDLER

inherit
	
	CONTENT_TYPES
		export
			{NONE} all;
			{ANY} First_content_type, Last_content_type
		end

	HTTP_STATUS_CODES
		export
			{NONE} all
		end
		
feature -- Basic operations

	service (file_name: STRING; content_type_code: INTEGER;
		req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Service the file request for the specified 'file_name' and
			-- 'content_type_code'. Send the file to 'resp'.
		require
			file_name_exists: file_name /= Void
			valid_content_type: content_type_code >= First_content_type 
				and content_type_code <= Last_content_type
			request_exists: req /= Void
			response_exists: resp /= Void
		deferred	
		end
			
feature {NONE} -- Implemtation

	buffer : STRING is
		once
			create Result.make (256 * 1024) -- 256 KB initiallly
			Result.fill_blank
		end
	
end -- class CONTENT_FILE_HANDLER
