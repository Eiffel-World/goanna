indexing
	description: "FastCGI simple request processor."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SIMPLE

inherit

	FAST_CGI_APP
		rename
			make as fast_cgi_app_make
		end

-- NOTE: the following export modification clauses are commented out because
-- the SmallEiffel compiler doesn't correctly compile them. Once SmallEiffel
-- catches up with the language definition, they need uncommenting.

	UT_STRING_FORMATTER
--		export
--			{NONE} all
--		end
	
	KL_SHARED_ARGUMENTS
--		export
--			{NONE} all
--		end
			
creation

	make

feature -- Initialisation

	make is
			-- Initialise application and begin request processing loop
		do
			if valid_arguments then
				fast_cgi_app_make (Arguments.argument (1).to_integer, Arguments.argument (2).to_integer)
				run
			end
		end
	
feature -- Basic Operations

	count: INTEGER

	process_request is
		local
			length: INTEGER
			param_keys: DS_HASH_TABLE_CURSOR [STRING, STRING]
		do
			warn ("Accepted -- YEAH! %N")

			length := getparam_integer (Content_length_var)

--			print (generator + ".process_request: length=" + length.out)
			
			putstr ("Content-type: text/html%R%N%R%N")
			putstr ("TESTING<br>%R%N")

			putstr ("Content Length: ")
			putstr (length.out)
			putstr ("<br>%R%N")
    
			putstr ("Visits: ")
			putstr (count.out)
			putstr ("<br>%R%N")
			count := count + 1

			-- output parameters
			param_keys := request.parameters.new_cursor
			from
				putstr ("Parameters:<br>%R%N")
				param_keys.start
			until
				param_keys.off
			loop
				putstr (param_keys.key + " = " 
					+ quoted_eiffel_string_out (param_keys.item))
				putstr ("<br>%R%N")
				param_keys.forth
			end
			
			-- read and display content
			if length > 0 then
				putstr ("<br>%R%NContent = " + quoted_eiffel_string_out (request.raw_stdin_content))
			end
		end

	valid_arguments: BOOLEAN is
			-- Check command line arguments for validity
		do
			Result := True
			if Arguments.argument_count /= 2 then
				display_error ("Error: Missing argument.")
				Result := False
			else
				if not Arguments.argument (1).is_integer or not Arguments.argument (2).is_integer then
					display_error ("Error: <port> and <queuesize> must be integer.")
					Result := False
				end
			end			
		end
	
	display_error (error: STRING) is
			-- Display error message and usage	
		require
			error_exists: error /= Void
		do
			io.put_string (error)
			io.put_new_line
			io.put_string (usage_text)
			io.put_new_line
		end
		
	usage_text: STRING is
			-- Usage help text
		once
			Result := "Usage: simple <port> <queuesize>"
		end

end -- class SIMPLE
