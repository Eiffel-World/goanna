indexing
	description: "Objects that can be evaluated"
	author: "Neal L. Lester"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVALUATEABLE

feature -- attributes

	evaluated : BOOLEAN is
		-- Has this object been evaluated?
		do
			result := not equal (status_code, 0)
		end

	not_evaluated : BOOLEAN is
		-- This object has not been evaluated
		do
			result := equal (status_code, 0)



	

feature {NONE} -- implementation

	update is
		-- The status_code has been changed
		deferred
		end

	status_code : INTEGER
		-- 

end -- class EVALUATEABLE
