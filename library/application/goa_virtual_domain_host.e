indexing
	description: "A virtual domain host; VIRTUAL_DOMAIN_HOST should inherit from this class"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_VIRTUAL_DOMAIN_HOST
	
feature -- Attributes

	style_sheet: STRING
			-- The style sheet to use with this host
			
	host_name: STRING
	
	base_url: STRING is
			-- URL to current virtual domain host
		do
			Result := "http://" + host_name + "/"
		end

			
feature -- Attribute Setting

	set_style_sheet (new_style_sheet: STRING) is
			-- Set style_sheet to new_style_sheet
		require
			valid_new_style_sheet: new_style_sheet /= Void and then not new_style_sheet.is_empty
		do
			style_sheet := new_style_sheet
		ensure
			style_sheet_updated: style_sheet = new_style_sheet
		end

	set_host_name (new_host_name: STRING) is
			-- Set host_name to new_host_name
		require
			valid_new_host_name: new_host_name /= Void and then not new_host_name.is_empty
		do
			host_name := new_host_name
		ensure
			host_name_updated: host_name = new_host_name
		end

	set_use_ssl is
			-- Set domain to to use ssl
		do
			use_ssl := True
		end
		
	use_ssl: BOOLEAN
			-- Does this site use SSL to protect traffic?

end -- class GOA_VIRTUAL_DOMAIN_HOST
