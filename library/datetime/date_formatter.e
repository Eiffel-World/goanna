indexing
	description: "Objects that format date time objects for display."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "datetime"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	DATE_FORMATTER

feature -- Transformation

	format_fixed_variant (date: DATE_AND_TIME): STRING is
			-- Format 'date' using the long display format.
			-- ie, "Wdy, DD-Mon-YY HH:MM:SS GMT".
			-- This format is suitable for cookie expiry dates.
			-- Will always display GMT timezone.
		require
			date_exists: date /= Void
		local
			formatter: FORMAT_INTEGER
			century: STRING
		do
			create formatter.make (2)
			formatter.right_justify
			formatter.zero_fill

			create Result.make (27)
			-- weekday
			Result.append (short_weekdays.item (date.day_of_week + 1))
			Result.append (", ")
			-- date
			Result.append (formatter.formatted (date.day))
			Result.append_character ('-')
			Result.append (short_months.item (date.month))
			Result.append_character ('-')
			century := date.year.out
			century.tail (2)
			Result.append (century)
			-- time
			Result.append_character (' ')
			Result.append (formatter.formatted (date.hour))
			Result.append_character (':')
			Result.append (formatter.formatted (date.minute))
			Result.append_character (':')
			Result.append (formatter.formatted (date.second))
			-- timezone
			Result.append (" GMT")
		ensure
			formatted_date_exists: Result /= Void
		end
		
	format_compact_sortable (date: DATE_AND_TIME): STRING is
			-- Format suitable for string sorting.
			-- ie, YYYYMMDDHHMMSS
		require
			date_exists: date /= Void
		local
			formatter: FORMAT_INTEGER
		do
			create formatter.make (2)
			formatter.right_justify
			formatter.zero_fill
			create Result.make (14)
			Result.append (date.year.out)
			Result.append (formatter.formatted (date.month))
			Result.append (formatter.formatted (date.day))
			Result.append (formatter.formatted (date.hour))
			Result.append (formatter.formatted (date.minute))
			Result.append (formatter.formatted (date.second))
		ensure
			formatted_date_exists: Result /= Void
		end
		
feature {NONE} -- Implementation

	short_weekdays: ARRAY [STRING] is 
			-- Short names for weekdays beginning at Sunday.
		once
			Result := << "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" >>
		ensure
			seven_days: Result.count = 7
		end	
	
	short_months: ARRAY [STRING] is
			-- Short names for months.
		once
			Result := << "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug",
				"Sep", "Oct", "Nov", "Dec" >>
		ensure
			twelve_months: Result.count = 12
		end
		
end -- class DATE_FORMATTER
