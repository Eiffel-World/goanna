indexing
	description: "Objects that compare cookie names for equality"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	COOKIE_NAME_EQUALITY_TESTER

inherit
	
	DS_EQUALITY_TESTER [COOKIE]
		redefine
			test
		end

feature -- Status report

	test (v, u: COOKIE): BOOLEAN is
			-- Do 'v' and 'u' have the same cookie name?
		do
			if v = void then
				Result := (u = void)
			elseif u = void then
				Result := False
			else
				Result := v.name.is_equal (u.name)
			end
		end
		
end -- class COOKIE_NAME_EQUALITY_TESTER
