indexing
	description: "System's root class";
	note: "Initial version automatically generated"

class
	SIMPLE

inherit

	FAST_CGI

creation

	make

feature -- Initialization

	count: INTEGER

	make is
		local
			read_str: STRING
			accept_result, content_length: INTEGER
		do
			from
				accept_result := accept
			until 
				accept_result < 0
			loop
				warn ("Accepted -- YEAH! %N")

				content_length := getparam_integer ("CONTENT_LENGTH")

				putstr ("Content-type: text/html%R%N%R%N")
				putstr ("TESTING<br>%N")

				putstr ("Content Length: ")
				putstr (content_length.out)
				putstr ("<br>%N")
	    
				putstr ("Visits: ")
				putstr (count.out)
				putstr ("<br>%N")
				count := count + 1

				putstr ("Server name: ")
				putstr (getparam ("SERVER_NAME"))
				putstr ("<br>%N")

				putstr ("User agent: ")
				putstr (getparam ("HTTP_USER_AGENT"))
				putstr ("<br>%N")

				if content_length > 0 then
					read_str := getstr (content_length)
					putstr ("Content: ")
					putstr (read_str)
					putstr ("%N")
				end
				accept_result := accept
			end
		end

end -- class SIMPLE
