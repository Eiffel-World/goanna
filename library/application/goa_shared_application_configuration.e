indexing
	description: "Shared access to APPLICATION_CONFIGURATION"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	
	GOA_SHARED_APPLICATION_CONFIGURATION
	
feature
	
	configuration: APPLICATION_CONFIGURATION is
			-- Application configuration
		require
			database_name_set_with_legal_name: configuration_table.has (shared_configuration_name)
		once
			Result := configuration_table.item (shared_configuration_name)
		end
		
	configuration_table: DS_HASH_TABLE [APPLICATION_CONFIGURATION, STRING] is
			-- Legal configurations indexed by database name
		local
			development_configuration: DEVELOPMENT_CONFIGURATION
			production_configuration: PRODUCTION_CONFIGURATION
		once
			create Result.make_equal (2)
		end
		
	shared_configuration_name: STRING is
			-- Shared access to database name set by COMMAND_LINE_PROCESSING
		once
			Result := ""
		end

end -- class GOA_SHARED_APPLICATION_CONFIG
