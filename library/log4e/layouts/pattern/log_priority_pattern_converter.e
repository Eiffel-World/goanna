indexing
	description: "Pattern converter for formatting priorities"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class LOG_PRIORITY_PATTERN_CONVERTER
	
inherit
	
	LOG_PATTERN_CONVERTER

creation
	
	make
		
feature {NONE} -- Implementation

	convert (event: LOG_EVENT): STRING is
			-- Convert conversion specifiers appropriately.
		do
			Result := event.priority.level_str
		end
	
end -- LOG_PRIORITY_PATTERN_CONVERTER
