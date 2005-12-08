indexing
	description: "Goanna Required Access to Objects associated with the user session; SESSION_STATUS should inherit from this class"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	GOA_SESSION_STATUS
	
inherit
	
	GOA_SHARED_VIRTUAL_DOMAIN_HOSTS
	GOA_AUTHENTICATION_STATUS_CODE_FACILITIES
	
feature -- Server Information

	virtual_domain_host: VIRTUAL_DOMAIN_HOST
			-- The virtual_domain_host that is hosting this session

	server_name: STRING
			-- The server name associated with this session

feature -- Access

	message_catalog: MESSAGE_CATALOG is
			-- System messages displayed to the user
		once
			create Result
		end
		
	has_served_a_page: BOOLEAN
			-- Has this session served a page yet?

	secure_page: GOA_DISPLAYABLE_SERVLET
			-- page to send via SSL connection on subsequent request from the user
			-- Used to forward user from an insecure request page to a secure response page
			
	initialized: BOOLEAN
			-- Has this object been initialized?

feature -- Status Setting

	set_secure_page (new_secure_page: GOA_DISPLAYABLE_SERVLET) is
		do
			secure_page := new_secure_page
		ensure
			secure_page_updated: secure_page = new_secure_page
		end
		
	set_server_name (new_server_name: STRING) is
			-- Set server_name to new_server_name
		require
			valid_new_server_name: new_server_name /= Void and then not new_server_name.is_empty
		do
			server_name := new_server_name
		ensure
			server_name_updated: server_name = new_server_name
		end

	set_has_served_a_page is
			-- Set has_served_a_page to true
		do
			has_served_a_page := True
		end
		
	set_virtual_domain_host (new_virtual_domain_host: VIRTUAL_DOMAIN_HOST) is
			-- Set virtual_domain_host for this session
		require
			valid_new_virtual_domain_host: new_virtual_domain_host /= Void
		do
			virtual_domain_host := new_virtual_domain_host
		end
		
feature {GOA_APPLICATION_SERVLET} -- Initialization

	initialize (processing_result: REQUEST_PROCESSING_RESULT) is
			-- Extract session status from req; initializing if necessary
		require
			valid_processing_result: processing_result /= Void
			not_initialized: not initialized
		local
			req: GOA_HTTP_SERVLET_REQUEST
		do
			req := processing_result.request
			if req.has_header ("SERVER_NAME") then
				server_name := req.get_header ("SERVER_NAME")
			else
				server_name := ""
			end
			set_virtual_domain_host (virtual_domain_for_host_name (server_name))
			initialized := True
		ensure
			initialized: initialized
			valid_server_name: server_name /= Void
			valid_virtual_domain_host: virtual_domain_host /= Void
		end

feature {NONE} 

	make is
			-- Creation
		do
			
		end
		

end -- class GOA_SESSION_STATUS
