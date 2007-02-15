indexing
	description: "A servlet that brings down the application"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_SHUT_DOWN_SERVER_SERVLET

inherit

	GOA_APPLICATION_SERVLET
		redefine
			perform_final_processing
		end
	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT

creation

	make

feature

	name: STRING is
		once
			Result := configuration.bring_down_server_servlet_name
		end

	perform_final_processing (processing_result: REQUEST_PROCESSING_RESULT) is
		do
			configuration.set_bring_down_server
			exceptions.raise (configuration.bring_down_server_exception_description)
		end

end -- class GOA_SHUT_DOWN_SERVER_SERVLET
