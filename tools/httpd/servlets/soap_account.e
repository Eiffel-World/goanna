indexing
	description: "Objects that encode and decode Base64 (RFC1521) strings."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTPD servlets"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_ACCOUNT

feature 

	deposit (amount: INTEGER_REF): INTEGER_REF is
			-- Deposit 'amount' in account
		do
			balance := balance + amount.item
			create Result
			Result.set_item (balance)
		end
		
	withdraw (amount: INTEGER_REF): INTEGER_REF is
			-- Withdraw 'amount' from account
		do
			balance := balance - amount.item
			create Result
			Result.set_item (balance)
		end
		
	balance: INTEGER
			-- Current account balance
		
end -- class SOAP_ACCOUNT
