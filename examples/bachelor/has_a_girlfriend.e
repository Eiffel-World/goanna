indexing
	description: "Does the user a girlfriend?"
	author: "Neal L. Lester (neal@3dsafety.com)"
	date: "$ May 14, 2001: $"
	revision: "$version 1.0$"

class
	HAS_A_GIRLFRIEND

inherit
	YES_NO_TOPIC

create
	make

feature

	question : STRING is
		do
			result := text.has_a_girlfriend
		end

	title : STRING is ""

end -- class HAS_A_GIRLFRIEND
