indexing

class

	HTTPD_LOGGER

inherit
	
	LOG_PRIORITY_CONSTANTS
		export
			{NONE} all
		end
		
feature -- Access

	log_hierarchy: LOG_HIERARCHY is
			-- Shared log hierarchy with predefined
			-- categories for HTTPD server logging
		local
			cat: LOG_CATEGORY
			appender: LOG_APPENDER
		once
			create Result.make (Debug_p)
			cat := Result.category (Internal_category_name)
			create {LOG_FILE_APPENDER} appender.make (Internal_log, True)
			cat.add_appender (appender)
			cat := Result.category (Access_category_name)
			create {LOG_FILE_APPENDER} appender.make (Access_log, True)
			cat.add_appender (appender)
		end
		
	internal_category: LOG_CATEGORY is
			-- Retrieve internal logging category
		do
			Result := log_hierarchy.category (Internal_category_name)
		end
	
	access_category: LOG_CATEGORY is
			-- Retrieve access logging category
		do
			Result := log_hierarchy.category (Access_category_name)
		end	
		
feature {NONE} -- Implementation

	Internal_category_name: STRING is "httpd.internal"

	Internal_log: STRING is "httpd.log"
	
	Access_category_name: STRING is "httpd.access"

	Access_log: STRING is "access.log"
	
end -- class HTTPD_LOGGER
