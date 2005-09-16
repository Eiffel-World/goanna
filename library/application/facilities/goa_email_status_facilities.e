indexing
	description: "Status codes for email addresses"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	GOA_EMAIL_STATUS_FACILIITES

feature
	
	email_not_validated: INTEGER is 0
			-- email address has not been validated
			
	email_invalid: INTEGER is 100
			-- email address is not valid
			
	email_valid: INTEGER is 200
			-- email passed validatioin
			
	email_confirmed: INTEGER is 300
			-- email address is confirmed good (recipient has confirmed receipt of an e-mail to this address)
			
	is_valid_email_status_code (the_code: INTEGER): BOOLEAN is
			-- Does the_code represent a valid email status code?
		do
			Result := valid_email_status_codes.has (the_code)
		end
			
	valid_email_status_codes: DS_LINKED_LIST [INTEGER] is
			-- Valid status codes
		once
			create Result.make_equal
			Result.force_last (email_not_validated)
			Result.force_last (email_invalid)
			Result.force_last (email_valid)
			Result.force_last (email_confirmed)
		end
		

end -- class GOA_EMAIL_STATUS_FACILIITES
