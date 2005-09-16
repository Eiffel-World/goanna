indexing
	description: "A hyperlink to a servlet on this website"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_INTERNAL_HYPERLINK

inherit
	GOA_HYPERLINK
	GOA_SHARED_APPLICATION_CONFIGURATION
	SHARED_SERVLETS
	SHARED_GOA_REQUEST_PARAMETERS
	
creation
	
	make
	
feature {NONE} -- Creation

	make (processing_result: REQUEST_PROCESSING_RESULT; servlet: GOA_APPLICATION_SERVLET; new_text: STRING) is
		require
			valid_processing_result: processing_result /= Void
			valid_servlet: servlet /= Void
			valid_new_text: new_text /= Void
		local
			virtual_host_name: STRING
			index: INTEGER
		do
			initialize
			text := clone (new_text)
			host_and_path := clone (processing_result.session_status.virtual_domain_host.host_name)
			host_and_path.append (configuration.fast_cgi_directory)
			host_and_path.append (clone (go_to_servlet.name))
			add_parameter (page_parameter.name, servlet.name_without_extension)
			if processing_result.session_status.virtual_domain_host.use_ssl and servlet.receive_secure then
				set_secure
			end
		end

end -- class GOA_INTERNAL_HYPERLINK
