indexing
	description: "Pattern converter for formatting categories"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class LOG_CATEGORY_PATTERN_CONVERTER
	
inherit
	
	LOG_PATTERN_CONVERTER
		rename
			make as pattern_converter_make
		export
			{NONE} pattern_converter_make		
		end
		
creation
	
	make
	
feature -- Initialisation
	
	make (formatting_info: LOG_FORMATTING_INFO; precision: INTEGER) is
			-- Initialise with 'formatting_info'.
		require
			formatting_info_exists: formatting_info /= Void
		do
			pattern_converter_make (formatting_info)
		end
		
feature {NONE} -- Implementation

	convert (event: LOG_EVENT): STRING is
			-- Convert conversion specifiers appropriately.
		do
			Result := event.category.name
		end
	
end -- LOG_CATEGORY_PATTERN_CONVERTER
