indexing
	description: "Logging appender that writes to Unix syslog via a UDP socket."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOG_SYSLOG_APPENDER

inherit
	
	LOG_APPENDER
		rename
			make as appender_make
		end

	LOG_SYSLOG_APPENDER_CONSTANTS
	
creation
	
	make, make_on_port

feature -- Initialization

	make (new_name, host: STRING; facility: INTEGER) is
			-- Initialise syslog appender that will send events to
			-- the syslod daemon listening at 'host'.
		require
			name_exists: new_name /= Void
			host_exists: host /= Void
			valid_facility: is_valid_facility (facility)
		do
			make_on_port (new_name, host, Syslog_port, facility)
		end

	make_on_port (new_name, host: STRING; port, facility: INTEGER) is
			-- Initialise syslog appender that will send events to
			-- the syslod daemon listening at 'host on UDP 'port'.
		require
			name_exists: new_name /= Void
			host_exists: host /= Void
			sensible_port: port > 0
			valid_facility: is_valid_facility (facility)
		do
			create socket.make_connecting_to_port (host, port)
			log_facility := facility
			appender_make (new_name)
		end	
		
feature -- Status Setting
	
	close is
			-- Release any resources for this appender.
		do
			if not is_open then
				socket.close	
			end
		end	

feature {NONE} -- Implementation

	do_append (event: LOG_EVENT) is
			-- Append 'event' to this appender
		do
		
		end	

	socket: UDP_SOCKET
			-- UDP socket for sending syslog datagrams
	
	log_facility: INTEGER
			-- Syslog facility to log messages with
			
	Syslog_port: INTEGER is 167
			-- Standard syslog UDP port.
			
end -- class LOG_SYSLOG_APPENDER
