indexing
	description: "A flexible layout using a pattern"
	usage: "[
		The conversion pattern is closely related to the printf function in C.
		is composed of literal text and format control expression called conversion
		specifiers.
		
		Each conversion specifier starts with an & character and is followed by
		optional format modifiers and a conversion character. The conversion 
		character specifies the type of data, e.g., category, priority, date,
		message. The format modifiers control such things as field width, padding,
		left and right justification.
		]"
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
			create converters.make
			parse_pattern (pattern)
		end
	
feature -- Rendering

	format (event: LOG_EVENT): STRING is
			-- Format contents of 'event' according to this layout's
			-- formatting rules.
			-- Apply all converters to event in order.
		local
			cursor: DS_LINKED_LIST_CURSOR [LOG_PATTERN_CONVERTER]
		do
			create Result.make (128)
			cursor := converters.new_cursor
			from
				cursor.start
			until
				cursor.off
			loop
				cursor.item.format (Result, event)
				cursor.forth
			end
		end

feature {NONE} -- Implementation
	
	parse_pattern (pattern: STRING) is
			-- Parse 'pattern' and create list of pattern elements for each
			-- distinct part.
		require
			pattern_exists: pattern /= Void
		local
			parser: LOG_PATTERN_PARSER
		do
			create parser.make (pattern)
			converters := parser.converters
		end
	
	converters: DS_LINKED_LIST [LOG_PATTERN_CONVERTER]
			-- List of pattern converters to apply.
	
end -- class LOG_PATTERN_LAYOUT
