indexing
	description: "Objects that represent a FastCGI servlet application."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_CGI_SERVLET_APP

inherit
	FAST_CGI_APP
	
	SERVLET_MANAGER
		rename
			make as servlet_manager_make
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make is
			-- 
		local
			
		do
			
		end
	
end -- class FAST_CGI_SERVLET_APP
