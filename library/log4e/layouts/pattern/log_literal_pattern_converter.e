indexing
	description: "Pattern converter for formatting literal strings"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class LOG_LITERAL_PATTERN_CONVERTER
	
inherit
	
	LOG_PATTERN_CONVERTER
		redefine
			format
		end
	
creation
	
	make
	
feature -- Initialisation
	
	make (value: STRING) is
			-- Create literal converter for 'value'
		require
			value_exists: value /= Void
		do
			literal := value
		end
	
feature -- Basic operations
	
	format (sbuf: STRING; event: LOG_LOGGING_EVENT) is
			-- Format literal and append to 'sbuf'
		do
			sbuf.append (literal)
		end
	
feature {NONE} -- Implementation
	
	literal: STRING
			-- String to format
	
	convert (event: LOG_LOGGING_EVENT): STRING is
			-- Convert conversion specifiers appropriately.
		do
			-- not used
		end
	
end -- LOG_PATTERN_CONVERTER
