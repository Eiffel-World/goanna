indexing
	description: "Pattern converter"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class LOG_PATTERN_CONVERTER
	
feature -- Initialisation
	
	make (formatting_info: LOG_FORMATTING_INFO) is
			-- Initialise with 'formatting_info'.
		require
			formatting_info_exists: formatting_info /= Void
		do
			min := formatting_info.min
			max := formatting_info.max
			align_left := formatting_info.align_left
		end
	
feature -- Status report
	
	min: INTEGER
			-- Minimum length of converted string, -1 for 
			-- no minimum.
	
	max: INTEGER
			-- Maximum length of converted string, 
			-- Max_integer for no maximum.
	
	
	left_align: BOOLEAN
			-- Should the string be left aligned.
	
	
feature -- Basic operations
	
	format (sbuf: STRING; event: LOG_LOGGING_EVENT) is
			-- Template routine for formatting in a converter
			-- specific way.
		require
			sbuf_exists: sbuf /= Void
			event_exists: event /= Void
		local
			s: STRING
			len: INTEGER
		do
			converted := convert (event)
			if s = Void then
				if 0 < min then
					space_pad (sbuf, min)
				end
			else
				len := s.count
				if len > max then
					sbuf.append (s.substring (len - max))
				elseif len < min then
					if left_align then
						sbuf.append (s)
						space_pad (sbuf, min - len)
					else
						space_pad (sbuf, min - len)
						sbuf.append (s)
					end
				else
					sbuf.append (s)
				end
			end
		end
	
feature {NONE} -- Implementation
	
	convert (event: LOG_LOGGING_EVENT): STRING is
			-- Convert conversion specifiers appropriately.
		require
			event_exists: event /= Void
		deferred
		ensure
			converted_string_exists: Result /= Void
		end
	
end -- LOG_PATTERN_CONVERTER

	
