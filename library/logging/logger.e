indexing
	description: "Objects that provide logging facilities."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "logging"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOGGER

creation
	make
	
feature -- Initialization

	make is
			-- Create a new logger
		do
			create channels.make (2)
		end
		
feature -- Access

	channel (facility: STRING): LOG_CHANNEL is
			-- Get log channel for 'facility'.
		require
			facility_exists: facility /= Void
			has_facility_channel: has_channel (facility)
		do
			Result := channels.item (facility)
		end
		
feature -- Status report

	has_channel (facility: STRING): BOOLEAN is
			-- Does a log channel exists for 'facility'?
		require
			facility_exists: facility /= Void
		do
			Result := channels.has (facility)		
		end
		
feature -- Element change

	add_channel (facility: STRING; new_channel: LOG_CHANNEL) is
			-- Add log channel 'channel' for logging facility 'facility'.
		require
			facility_exists: facility /= Void
			channel_exists: new_channel /= Void
			facility_not_registered: not has_channel (facility)
		do
			channels.force (new_channel, facility)
		ensure
			facility_registered: has_channel (facility)
		end

feature -- Removal
	
	remove_channel (facility: STRING) is
			-- Remove log channel for logging facility 'facility'.
		require
			facility_exists: facility /= Void
			facility_registered: has_channel (facility)
		do
			channels.remove (facility)
		ensure
			facility_not_registered: not has_channel (facility)
		end
		
feature {NONE} -- Implementation

	channels: HASH_TABLE [LOG_CHANNEL, STRING]
			-- Log channels indexed by facility

end -- class LOGGER
