indexing
	description: "Objects that can process FastCGI requests."
	author: "Glenn Maughan"
	original: "Lyn Headley, http://eiffel-forum.org/archive/headley/small-fcgi.htm"
	revision: "$Revision$"
	date: "$Date$"

class FAST_CGI

inherit

	FAST_CGI_EXTERNALS
		export
			{NONE} all
		end

	FAST_CGI_VARIABLES
		export
			{NONE} all
		end

feature -- FGCI functionality

	accept: INTEGER is 
			-- Accept a new request from the HTTP server and create
			-- a CGI-compatible execution environment for the request.
			-- Returns zero for a successful call, -1 for error.
      	do
			Result := c_fcgi_accept
		end

	finish is 
			-- Finish the current request from the HTTP server. The
			-- current request was started by the most recent call to 
			-- 'accept'.
		do
			c_fcgi_finish
		end

	flush is 
			-- Flush output and error streams.
		do
			c_fcgi_flush
		end

	putstr (str: STRING) is 
      		-- Print 'str' to standard output stream.
		local
			c_str: ANY
		do 
			c_str := str.to_c
			c_fcgi_print ($c_str)
		end

	warn (str: STRING) is 
			-- Print 'str' to standard error stream.
		local
			c_str: ANY
		do 
			c_str := str.to_c
			c_fcgi_warn ($c_str)
		end

	getstr (amount: INTEGER): STRING is 
			-- Read 'amount' characters from standard input stream.
		do
			Result := c_fcgi_getstr (amount)
		end

	getline (amount: INTEGER): STRING is
			-- Read up to n - 1 consecutive bytes from the input stream
			-- into the Result. Stops before n - 1 bytes have been read
			-- if '%N' or EOF is read.
		do
			Result := c_fcgi_getline (amount)
		end

	getparam (name: STRING): STRING is
			-- Get the value of the named environment variable.
		local
			c_str: ANY
		do
			c_str := name.to_c
			Result := c_fcgi_getparam ($c_str)
		end

	getparam_integer(name: STRING): INTEGER is
			-- Fetch and convert environment variable
	 		-- Returns 0 on failure.
		local
			str: STRING
		do
			str := getparam (name)
			if str.is_integer then
				Result := str.to_integer
			end
		end

	is_cgi: BOOLEAN is
			-- Is the process a CGI process rather than a FastCGI process?
		do
			Result := c_is_cgi
		end

end -- class FAST_CGI

