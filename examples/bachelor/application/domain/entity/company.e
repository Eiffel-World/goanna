indexing
	description: "Objects that represent Companies or Corporations"
	author: "Neal L. Lester"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) 2001 Neal L. Lester"

class
	COMPANY

inherit
	ENTITY
		redefine
			company
		end

create
	make

feature -- Access

	company: COMPANY is
			-- The company associated with this entity
		do
			result := current
		end
		
feature {NONE} -- creation
	
	make is
			-- Creation
		do
			initialize
		end

end -- class COMPANY
