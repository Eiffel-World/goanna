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

	c_is_cgi: BOOLEAN is
		external
			"C | %"efcgi.h%""
		end

end -- class FAST_CGI_EXTERNALS

