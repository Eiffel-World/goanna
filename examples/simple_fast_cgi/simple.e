indexing
	description: "System's root class";
	note: "Initial version automatically generated"

class
	SIMPLE

inherit

	FAST_CGI_APP
		rename
			make as fast_cgi_app_make
		end

	UT_STRING_FORMATTER
		export
			{NONE} all
		end
	
	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end
		
	MEMORY
		export
			{NONE} all
		end
			
creation

	make

feature -- Initialisation

	make is
			-- Initialise application and begin request processing loop
		do
			fast_cgi_app_make (Arguments.argument (1).to_integer, Arguments.argument (2).to_integer)
			run
		end
	
feature -- Basic Operations

	count: INTEGER

	process_request is
		local
			content: STRING
			i, length: INTEGER
			param_keys: ARRAY [STRING]
		do
			warn ("Accepted -- YEAH! %N")

			length := getparam_integer (Content_length)

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
			param_keys := request.parameters.current_keys
			from
				putstr ("Parameters:<br>%R%N")
				i := param_keys.lower
			until
				i >= param_keys.upper
			loop
				putstr (param_keys.item (i) + " = " 
					+ quoted_eiffel_string_out (request.parameters.item (param_keys.item (i))))
				putstr ("<br>%R%N")
				i := i + 1
			end
			
			-- read and display content
			if length > 0 then
				putstr ("<br>%R%NContent = " + quoted_eiffel_string_out (request.raw_stdin_content))
			end
		end

end -- class SIMPLE
