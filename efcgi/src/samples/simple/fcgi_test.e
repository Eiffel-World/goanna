class FCGI_TEST
inherit FCGI

creation make

feature

   make is
      local
	 read_str: STRING
	 content_length: INTEGER
      do
	 from
	 until fcgi_accept < 0
	 loop
	    -- this should appear in the logs
	    fcgi_warn("Accepted -- YEAH! %N")

	    content_length := getenv_integer("CONTENT_LENGTH")

	    fcgi_print("Content-type: text/html%R%N%R%N")
	    fcgi_print("TESTING<br>%N")

	    fcgi_print("Content Length: ")
	    fcgi_print(content_length.to_string)
	    fcgi_print("<br>%N")
	    
	    if content_length > 0 then
	       read_str := fcgi_read(content_length)
	       fcgi_print("Content: ")
	       fcgi_print(read_str)
	       fcgi_print("%N")
	    end

	 end
      end
end
