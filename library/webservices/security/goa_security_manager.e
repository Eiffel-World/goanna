indexing
	description: "Security manager."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "web services security"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_SECURITY_MANAGER

create

	default_create

feature -- Initialization

	default_create is
			-- Initialise with no security realms.
		do
			create realms
		end
	
feature -- Access

	get_realm (name: STRING): GOA_SECURITY_REALM is
			-- Access the realm named 'name'
		require
			realm_registered: has_realm (name)
		do
			Result := realms.item (name)
		end
		
feature -- Status setting

	add_realm (new_realm: GOA_SECURITY_REALM) is
			-- Add 'new_zone' to the known security realms
		require
			realm_not_registered: not has_realm (new_realm.name)
		do
			realms.put (new_realm, new_realm.name)
		ensure
			realm_registered: has_realm (new_realm.name)
		end
	
feature -- Status report

	has_realm (name: STRING): BOOLEAN is
			-- Does a realm named 'name' exist in this security
			-- manager?
		do
			Result := realms.has (name)
		end
		
feature {NONE} -- Implementation

	realms: DS_HASH_TABLE [GOA_SECURITY_REALM, STRING]
			-- Collection of security realms indexed by zone name

invariant
	
	realms_exists: realms /= Void
	
end -- class GOA_SECURITY_MANAGER
