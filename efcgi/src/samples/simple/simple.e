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

creation

	make

feature -- Initialisation

	make is
			-- Initialise application and begin request processing loop
		do
			fast_cgi_app_make (8000, 5)
			run
		end
	
feature -- Basic Operations

	count: INTEGER

	process_request is
		local
			read_str: STRING
			length: INTEGER
		do
			warn ("Accepted -- YEAH! %N")

			length := getparam_integer (Content_length)

--			print (generator + ".process_request: length=" + length.out)
			
			putstr ("Content-type: text/html%R%N%R%N")
			putstr ("TESTING<br>%N")

			putstr ("Content Length: ")
			putstr (length.out)
			putstr ("<br>%N")
    
			putstr ("Visits: ")
			putstr (count.out)
			putstr ("<br>%N")
			count := count + 1

			putstr ("Server name: ")
			putstr (getparam (Server_name))
			putstr ("<br>%N")

			putstr ("User agent: ")
			putstr (getparam (Http_user_agent))
			putstr ("<br>%N")

			if length > 0 then
				read_str := getstr (length)
				putstr ("Content: ")
				putstr (read_str)
				putstr ("%N")
			end
		end

end -- class SIMPLE
