indexing
	description: "Objects that hold configuration data for a servlet."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SERVLET_CONFIG

feature -- Access

	document_root: STRING
			-- Root directory for documents
			
feature -- Status setting

	set_document_root (dir: STRING) is
			-- Set the document root to 'dir'
		require
			dir_exists: dir /= Void
		do
			document_root := dir
		end
		
end -- class SERVLET_CONFIG
