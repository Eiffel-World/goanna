indexing
	description: "Domains with a state than can be represented by an integer code"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI Applications"
	date: "$Date: 2001/06/13"
	revision: "$Revision$"
	author: "Neal L. Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Lockheed-Martin Space System Company"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	STATUS_DOMAIN

inherit
	DOMAIN

feature

	evaluated : BOOLEAN is
		-- Has this object been evaluated?
		do
			result := not equal (status_code, not_evaluated_code)
		end

	reset is
		-- reset the status to not_evaluated
		do
			set_status_code (not_evaluated_code)
		end

feature {NONE} -- implementation

	status_code : INTEGER
			-- An integer representing the current status of the object

	set_status_code (new_status_code : INTEGER) is
			-- set the new status code
		require
			new_status_code_exists : new_status_code /= Void
		do
			status_code := new_status_code
			update
		ensure
			status_code_updated : status_code = new_status_code
		end

	not_evaluated_code : INTEGER is 0
			-- The code corresponding to a status of 'not_evaluated'

invariant

	not_evaluated_code_zero : equal (not_evaluated_code, 0)
	evaluated_implies_status_code__not_not_evaluated_code : evaluated implies not equal (status_code, not_evaluated_code)

end -- class STATUS_DOMAIN
