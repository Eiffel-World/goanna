indexing
	description: "Selection of a programming language"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) 2005 Neal L. Lester and others"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class

	PROGRAMMING_LANGUAGE_SELECTION

creation
	
	make
	
feature -- Attributes

	name: STRING
			-- Name of the programming language
			
	comment: STRING
			-- A comment about the programming language
			
	valid_comment (the_comment: STRING): BOOLEAN is
			-- Is the_comment valid?
		require
			valid_comment: the_comment /= Void and then not the_comment.is_empty
		do
			Result := the_comment.item (1) = '(' and the_comment.item (the_comment.count) = ')'
		end
		
feature {NONE} -- Creation

	make (new_name, new_comment: STRING) is
		require
			valid_new_name: new_name /= Void and then not new_name.is_empty
			valid_new_comment: new_comment /= Void and then not new_comment.is_empty and then valid_comment (new_comment)
		do
			name := new_name
			comment := new_comment
		end

invariant
	
	valid_name: name /= Void and then not name.is_empty
	valid_comment: comment /= Void and then not comment.is_empty and then valid_comment (comment)

end -- class PROGRAMMING_LANGUAGE_SELECTION
