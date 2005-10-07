indexing
	description: "Shared access to APPLICATION_CONFIGURATION"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	
	GOA_SHARED_APPLICATION_CONFIGURATION
	
feature
	
	configuration: APPLICATION_CONFIGURATION is
			-- Application configuration
		once
			Result := active_configuration
		end
		
	active_configuration: APPLICATION_CONFIGURATION
			-- Configuration to use for this run
			
	touch_configuration is
			-- Touch the configuration object to instantiate the once function
		require
			valid_active_configuration: active_configuration /= Void
		local
			a_string: STRING
		do
			a_string := configuration.data_directory
		end
		
end -- class GOA_SHARED_APPLICATION_CONFIG
