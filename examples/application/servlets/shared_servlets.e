indexing
	description: "Shared Access to Servlets"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) 2005 Neal L. Lester and others"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	SHARED_SERVLETS

inherit

	GOA_SHARED_SERVLETS

feature -- Servlets

	question_servlet: QUESTION_SERVLET is
			-- Servlet that asks the user some questions
		once
			create Result.make
		end
		
	answer_servlet: ANSWER_SERVLET is
			-- Servlet that displays the user's answers
		once
			create Result.make
		end

end -- class SHARED_SERVLETS
