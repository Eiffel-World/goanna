class FCGI

-- FIXME: add DBC

feature {ANY}
   -- basic FCGI functionality

   fcgi_accept: INTEGER is 
      -- accept fastcgi connection
      external "C_WithoutCurrent" end

   fcgi_finish is 
      -- finish fastcgi connection
      external "C_WithoutCurrent" end

   fcgi_flush is 
      -- flush fastcgi output/error
      external "C_WithoutCurrent" end

   fcgi_print(str: STRING) is 
      -- print str to "standard output"
      do 
	 c_fcgi_print(str.to_external)
      end

   fcgi_warn(str: STRING) is 
      -- print str to "standard error"
      do 
	 c_fcgi_warn(str.to_external)
      end

   -- TESTME
   fcgi_read(amount: INTEGER): STRING is 
      -- read amount characters from "standard input"
      do
	 !!Result.from_external(c_fcgi_read(amount))
      end

   fcgi_getenv(var: STRING): STRING is
      -- get the value of the named environment variable
      do
	 !!Result.from_external(c_fcgi_getenv(var.to_external))
      end


feature {ANY}
   -- higher level services

   getenv_integer(var: STRING): INTEGER is
	 -- fetch and convert environment variable
	 -- returns 0 on failure (bad idea?)
      local
	 str: STRING
      do
	 str := fcgi_getenv(var)
	 if str.is_integer then
	    Result := str.to_integer
	 end	 
      end


feature {NONE} 
   -- private C interface

   c_fcgi_print(p: POINTER) is 
      external "C_WithoutCurrent" 
      alias "fcgi_print"  -- the name of the C function
      end

   c_fcgi_warn(p: POINTER) is 
      external "C_WithoutCurrent" 
      alias "fcgi_warn"  -- the name of the C function
      end

   c_fcgi_read(amount: INTEGER): POINTER is 
      external "C_WithoutCurrent" 
      alias "fcgi_read"
      end

   c_fcgi_getenv(var: POINTER): POINTER is
      external "C_WithoutCurrent"
      alias "fcgi_getenv"
      end
end

