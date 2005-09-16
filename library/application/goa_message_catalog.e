indexing
	description: "System Messages displayed to the user"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

-- MESSAGE_CATALOG should inherit from this class
-- The design intent is that this should (eventually) be a fully deferred class
-- Which effective descendents for each language supported by the web site.

class
	GOA_MESSAGE_CATALOG
	
feature

	attribute_unchanged_message (new_label, old_value: STRING):STRING is
			-- Message indicating an attribute was not changed
		require
			valid_new_label: new_label /= Void and then not new_label.is_empty
			valid_old_value: old_value /= Void and then not old_value.is_empty
		do
			Result := new_label + " was not updated and remains %'" + old_value + "%'."
		end
		
	is_required_message: STRING is "may not be empty."

	invalid_email_message: STRING is
		do
			Result := "The " + email_address_label + " is not a valid e-mail address.  Please enter the correct " + email_address_label
		end

	email_address_label: STRING is "e-Mail Address"
			-- label for the email address field
	
	email_address_not_updated: STRING is
			-- Email address was not updated
		do
			Result := "Your " + email_address_label + " was not updated."
		end		
	
	password_label: STRING is "Password"
			-- Password text input label
			
	confirm_label (the_label: STRING): STRING is
			-- Conrirm the_label field label
		require
			valid_the_label: the_label /= Void and then not the_label.is_empty
		do
			Result := "Confirm " + the_label
		end

end -- class GOA_MESSAGE_CATALOG
