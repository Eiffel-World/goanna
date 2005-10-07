indexing
	description: "Shared access to goa servlets; SHARED_SERVLETS should inherit from this class"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) 2005 Neal L. Lester and others"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	GOA_SHARED_SERVLETS
	
feature -- Servlets

	go_to_servlet: GOA_GO_TO_SERVLET is
			-- Servlet that allows direct hyperlinking to another MSP_DISPLAYABLE_SERVLET
		once
			create Result.make
		end
		
	secure_redirection_servlet: GOA_SECURE_REDIRECTION_SERVLET is
			-- Servlet used to redirect user to a secure page
		once
			create Result.make
		end
		
feature {NONE} -- Registration

	servlet_by_name: DS_HASH_TABLE [GOA_APPLICATION_SERVLET, STRING] is
			-- Servlets registered by name without extension
		once
			create Result.make_equal (30)
		end

end -- class GOA_SHARED_SERVLETS
