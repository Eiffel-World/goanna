indexing
	description: "Pattern parser"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOG_PATTERN_PARSER
	
inherit
	
	LOG_SHARED_LOG_LOG
		export
			{NONE} all
		end
	
creation
	
	make
	
feature -- Initialisation

	make (new_pattern: STRING) is
			-- Parse 'new_pattern' and make pattern converter 
			-- list available in 'converters'. If an 
			-- error occurs then log errors and set 'ok' 
			-- to False.
		require
			pattern_exists: new_pattern /= Void
		do
			create converters.make
			pattern := new_pattern
			pattern_length := pattern.count
			state := Literal_state
			parse_pattern
		end
	
feature -- Status report
	
	converters: DS_LINKED_LIST [LOG_PATTERN_CONVERTER]
			-- List of pattern converters to apply.
	
	ok: BOOLEAN
			-- Was parse successful?
	
feature {NONE} -- Implementation
	
	Escape_char: CHARACTER is '&'
	
	Literal_state: INTEGER is unique
	Converter_state: INTEGER is unique
	Minus_state: INTEGER is unique
	Dot_state: INTEGER is unique
	Min_state: INTEGER is unique
	Max_state: INTEGER is unique
	
	state: INTEGER
	current_literal: STRING
	pattern_length: INTEGER
	i: INTEGER
	formatting_info: LOG_FORMATTING_INFO
	pattern: STRING
	
	extract_option: STRING is
			-- Extract option string from current position
		local
			last: INTEGER
		do
			if i <= pattern_length and pattern.item (i) = '{' then
				last = pattern.index_of ('}', i)
				if last > i then
					Result := pattern.substring (i + 1, last)
					i := last + 1
				end
			end
		end
	
	extract_precision_option: INTEGER is
			-- Extract precision option. Expected to be 
			-- in decimal and positive. In case of error 
			-- zero is returned.
		local
			opt: STRING
		do
			opt := extract_option
			if opt /= Void then
				if opt.is_integer then
					Result := opt.to_integer
					if Result <= 0 then
						internal_log.error ("Presision option (" + opt + ") isn't a positive integer.")
					end
				end
			end
		end
	
	parse_pattern is
			-- Parse 'pattern' and create list of pattern elements for each
			-- distinct part.
		require
			pattern_exists: pattern /= Void
		local
			c: CHARACTER
			converter: LOG_PATTERN_CONVERTER
		do
			from
				i := 1
				c := pattern.item (i)
				i := i + 1
			until
				i <= pattern_length
			loop
				inspect state
				when Literal_state then
					if i = pattern_length then
						current_literal.append_character (c)
					elseif c = Escape_char then
						-- peek at the next char
						inspect pattern.item (i)
						when Escape_char then
							current_literal.append_character (c)
							i := i + 1
						when 'n' then
							current_literal.append_character ("%N")
							i := i + 1
						else
							if current_literal.count /= 0 then
								create {LOG_LITERAL_PATTERN_CONVERTER} converter.make (current_literal)
								converters.force_last (converter)
							end
							current_literal.wipe_out
							current_literal.append_character (c)
							state := Converter_state
							formatting_info.reset
						end
					else
						current_literal.append_character (c)
					end
				when Converter_state then
					current_literal.append_character (c)
					inspect c 
					when '-' then
						formatting_info.set_left_align
					when '.' then
						if c >= '0' and c <= '9' then
							formatting_info.set_min (c - '0')
							state := Min_state
						else
							finalize_converter (c)
						end
					end
				when Min_state then
					current_literal.append_character (c)
					if c >= '0' and c <= '9' then
						formatting_info.set_min (formatting_info.min * 10 + (c - '0'))
					elseif c = '.' then
						state := Dot_state
					else
						finalize_converter (c)
					end
				when Dot_state then
					current_literal.append_character (c)
					if c >= '0' and c <= '9' then
						formatting_info.set_max (c - '0')
						state := Max_state
					else
						internal_log.error ("Error occured in position " + i + 
								    ".%N Was expecting digit, instead got char '" + c + "'.")
						state := Literal_state
					end
				when Max_state then
					current_literal.append_character (c)
					if c >= '0' and c <= '9' then
						formatting_info.set_max (formatting_info.max * 10 + (c - '0'))
					else
						finalize_converter (c)
						state := Literal_state
					end
				end
			end
			if current_literal.count /= 0 then 
				create {LOG_LITERAL_PATTERN_CONVERTER} converter.make (current_literal)
				converters.force_last (converter)
			end
		end
	
	finalize_converter (c: CHARACTER) is
		local
			converter: LOG_PATTERN_CONVERTER
		do
			inspect c
			when 'c' then
				create {LOG_CATEGORY_PATTERN_CONVERTER} converter.make (formatting_info, 
										extract_precision_option)
			when 'd' then
				create {LOG_DATE_PATTERN_CONVERTER} converter.make (formatting_info, extract_option)
			when 'm' then
				create {LOG_MESSAGE_PATTERN_CONVERTER} converter.make (formatting_info)
			when 'r' then
				create {LOG_RELATIVE_TIME_PATTERN_CONVERTER} converter.make (formatting_info)
			else
				internal_log.error ("Unexpected char [" + c + "at position " + i + " in conversion pattern.")
				create {LOG_LITERAL_PATTERN_CONVERTER} converter.make (current_literal)
			end
			current_literal.wipe_out
			add_converter (converter)
		end
	
	add_converter (converter: LOG_PATTERN_CONVERTER) is
			-- Add 'converter' to list of pattern converters.
		require
			converter_exists: converter /= Void
		do
			current_literal.wipe_out
			converters.force_last (converter)
			state := Literal_state
			formatting_info.reset
		end
	
end -- class LOG_PATTERN_LAYOUT
