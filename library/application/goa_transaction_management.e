indexing
	description: "Interface for providing database transaction management services"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	
	GOA_TRANSACTION_MANAGEMENT

feature -- Access to data structures
		
	ok_to_read_data (processing_result: GOA_REQUEST_PROCESSING_RESULT): BOOLEAN is
			-- Is system in a state where data may be read from data structures?
		require
			valid_processing_result: processing_result /= Void
		deferred
		end
	
	ok_to_write_data (processing_result: GOA_REQUEST_PROCESSING_RESULT): BOOLEAN is
			-- Is system in a state where data written to data structures?
		require
			valid_processing_result: processing_result /= Void
		deferred
		end
		
	start_transaction (processing_result: GOA_REQUEST_PROCESSING_RESULT) is
			-- Place system in state where information may be written to data structures
		require
			valid_processing_result: processing_result /= Void
			ok_to_start_transaction (processing_result)
		deferred
		ensure
			ok_to_write_data: ok_to_write_data (processing_result)
		end
		
	start_version_access (processing_result: GOA_REQUEST_PROCESSING_RESULT) is
			-- Place system in state where information may be read from data structures
		require
			valid_processing_result: processing_result /= Void
			ok_to_start_version_access (processing_result)
		deferred
		ensure
			ok_to_read_data: ok_to_read_data (processing_result)
		end
		
	end_version_access (processing_result: GOA_REQUEST_PROCESSING_RESULT) is
			-- End state where information may be read from data structures
		require
			ok_to_end_version_access (processing_result)
		deferred
		end
		
	commit (processing_result: GOA_REQUEST_PROCESSING_RESULT) is
			-- Commit all changes to data structures
		require
			valid_processing_result: processing_result /= Void
			ok_to_commit (processing_result)
		deferred
		end
		
	ok_to_start_transaction (processing_result: GOA_REQUEST_PROCESSING_RESULT): BOOLEAN is
			-- Can we currently start a transaction?
		require
			valid_processing_result: processing_result /= Void
		deferred
		end
		
	ok_to_start_version_access (processing_result: GOA_REQUEST_PROCESSING_RESULT): BOOLEAN is
			-- Can we currently start a version access?
		require
			valid_processing_result: processing_result /= Void
		deferred
		end		
		
	ok_to_end_version_access (processing_result: GOA_REQUEST_PROCESSING_RESULT): BOOLEAN is
			-- Can we currently call end_version_access?
		require
			valid_processing_result: processing_result /= Void
		deferred
		end		
		
	ok_to_commit (processing_result: GOA_REQUEST_PROCESSING_RESULT): BOOLEAN is
			-- Can we currently call commit?
		require
			valid_processing_result: processing_result /= Void
		deferred
		end
		
	implements_transaction_and_version_access: BOOLEAN is
			-- Does this class implement transaction and version access control?
		deferred
		end

end -- class GOA_TRANSACTION_MANAGEMENT
