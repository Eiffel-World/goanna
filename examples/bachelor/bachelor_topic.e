indexing
	description: "A Topic used in the bachelor application"
	author: "Neal L. Lester"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BACHELOR_TOPIC

	inherit
		TOPIC
			undefine
				initialize, undo, receive_child_notification, parent_initialized, update, make, make_root
			end

feature 

	reset is
		deferred
	end

end -- class BACHELOR_TOPIC