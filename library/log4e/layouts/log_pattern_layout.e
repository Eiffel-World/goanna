indexing
	description: "Simple layout using 'priority - message'"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOG_PATTERN_LAYOUT

inherit

	LOG_SIMPLE_LAYOUT
		redefine
			format
		end
	
creation
	
	make
	
feature -- Initialisation

	make (pattern: STRING) is
			-- Create new pattern layout using 'new_pattern' to format
			-- the message
		require
			pattern_exists: pattern /= Void
		do
			parse_pattern (pattern)
		end
	
feature {NONE} -- Implementation

	
	parse_pattern (pattern: STRING) is
			-- Parse 'pattern' and create list of pattern elements for each
			-- distinct part.
		require
			pattern_exists: pattern /= Void
		do
			
		end
		
end -- class LOG_PATTERN_LAYOUT
