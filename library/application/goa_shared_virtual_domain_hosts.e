indexing
	description: "Shared access to Virtual Domain Hosts and related facilities"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_SHARED_VIRTUAL_DOMAIN_HOSTS
	
inherit
	
	GOA_SHARED_APPLICATION_CONFIGURATION
	
feature {NONE}
	
	virtual_domain_for_host_name (host_name: STRING): VIRTUAL_DOMAIN_HOST is
			-- Return virtual domain assigned to the host name
		do
			if virtual_domain_hosts.has (host_name) then
				Result := virtual_domain_hosts.item (host_name.as_lower)
			else
				Result := virtual_domain_hosts.item (configuration.default_virtual_host_lookup_string)
			end
		ensure
			valid_result: Result /= Void
		end
	
	virtual_domain_hosts: HASH_TABLE [VIRTUAL_DOMAIN_HOST, STRING] is
			-- Table containing all virtual domain hosts
		once
			create Result.make (25)
		end
	
invariant
	
	valid_virtual_domain_hosts: virtual_domain_hosts /= Void
	virtual_domain_hosts_has_default: virtual_domain_hosts.has (configuration.default_virtual_host_lookup_string)

end -- class GOA_SHARED_VIRTUAL_DOMAIN_HOSTS
