indexing
	description: "External FastCGI routines."
	author: "Glenn Maughan"
	original: "Lyn Headley, http://eiffel-forum.org/archive/headley/small-fcgi.htm"
	revision: "$Revision$"
	date: "$Date$"

class FAST_CGI_EXTERNALS

feature {NONE} -- External routines

	c_fcgi_accept: INTEGER is 
      	external
			"C | %"efcgi.h%""
		end

	c_fcgi_finish is 
		external
			"C | %"efcgi.h%""
		end

	c_fcgi_flush is 
		external
			"C | %"efcgi.h%""
		end

	c_fcgi_print (str: POINTER) is 
		external
			"C | %"efcgi.h%""
		end

	c_fcgi_warn (str: POINTER) is 
		external
			"C |%"efcgi.h%""
		end

	c_fcgi_getstr (amount: INTEGER): STRING is 
		external
			"C | %"efcgi.h%""
		end

	c_fcgi_getline (amount: INTEGER): STRING is 
		external
			"C | %"efcgi.h%""
		end

	c_fcgi_getparam (name: POINTER): STRING is
		external
			"C | %"efcgi.h%""
		end

	c_fcgx_is_cgi: BOOLEAN is
		external
			"C (): EIF_BOOLEAN | %"efcgi.h%""
		alias
			"FCGX_IsCGI"
		end
	
	c_fcgx_init: INTEGER is
		external
			"C | %"efcgi.h%""
		end
	
	c_fcgx_open_socket (path: POINTER; backlog: INTEGER): INTEGER is	
		external
			"C | %"efcgi.h%""
		alias
			"FCGX_OpenSocket"	
		end
	
	c_fcgx_init_request (sock, flags: INTEGER): POINTER is
		external
			"C | %"efcgi.h%""
		end
		
	c_fcgx_accept_r (request: POINTER): INTEGER is
		external
			"C (EIF_POINTER): EIF_INTEGER | %"efcgi.h%""
		alias
			"FCGX_Accept_r"
		end
	
	c_fcgx_finish_r (request: POINTER) is
		external
			"C | %"efcgi.h%""	
		alias
			"FCGX_Finish_r"
		end
	
end -- class FAST_CGI_EXTERNALS

