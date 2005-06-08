indexing
	description: "SOAP features (including MEPs) "
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Colin Adams <colin@colina.demon.co.uk>"
	copyright: "Copyright (c) 2005 Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

deferred class	GOA_SOAP_FEATURE

feature {NONE} -- Initialization

	init (a_name: like name) is
			--	Establish invariant (to be called from `make'.
		require
			name_exists: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end
	
feature -- Access

	name: UT_URI
			-- Name of feature

invariant

	name_exists: name /= Void

end -- class GOA_SOAP_FEATURE

