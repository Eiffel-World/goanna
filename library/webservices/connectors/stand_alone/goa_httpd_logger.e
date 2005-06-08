indexing

class GOA_HTTPD_LOGGER

inherit
	
	L4E_PRIORITY_CONSTANTS
		export
			{NONE} all
		end
	
	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end
	
feature -- Access

	log_hierarchy: L4E_HIERARCHY is
			-- Shared log hierarchy with predefined
			-- categories for HTTPD server logging
		local
			appender: L4E_APPENDER
			layout: L4E_LAYOUT
		once
			create Result.make (Debug_p)
			create {L4E_FILE_APPENDER} appender.make (Application_log, True)
			create {L4E_PATTERN_LAYOUT} layout.make ("@d [@-6p] @c - @m%N")
			appender.set_layout (layout)
			Result.root.add_appender (appender)
		end
		
feature {NONE} -- Implementation

	Internal_category: STRING is "httpd.internal"

	Access_category: STRING is "httpd.access"

	Application_log: STRING is
			-- Construct application log from system name and ".log" extension.
			-- Any leading path and extension will be removed. eg. The log file
			-- for 'd:\dev\httpd.exe' will be 'httpd.log' not 'd:\dev\httpd.exe.log'
		local
			app_name: STRING
--			p: INTEGER
		once
			app_name := clone (Arguments.argument (0))
-- Commented out for SmallEiffel support			
--			p := app_name.last_index_of ('.', app_name.count)
--			if p > 0 then
--				app_name := app_name.substring (1, p - 1)
--			end
			create Result.make (app_name.count + 4)
			Result.append (app_name)
			Result.append (".log")
		end
	
end -- class GOA_HTTPD_LOGGER
