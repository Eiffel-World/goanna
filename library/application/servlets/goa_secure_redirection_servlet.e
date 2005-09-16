indexing
	description: "A servlet that redirects user to a secure version of a displayable_servlet"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_SECURE_REDIRECTION_SERVLET

inherit
	
	GOA_APPLICATION_SERVLET
		redefine
			make
		end
	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT

creation
	
	make
	
feature

	name: STRING is "go_to_secure_page.htm"
	
feature {NONE} -- Creation

	make is
		do
			Precursor
			receive_secure := True
		end
	
end -- class GOA_SECURE_REDIRECTION_SERVLET
