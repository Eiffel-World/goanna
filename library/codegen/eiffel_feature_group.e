indexing
	description: "Objects that represent a group of Eiffel feature with common export status."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_FEATURE_GROUP

inherit

	EIFFEL_CODE

creation

	make

feature -- Initialization

	make (new_comment: STRING) is
			-- Create an empty feature group with 'comment'
		require
			comment_exists: new_comment /= Void
		do
			set_comment (new_comment)
			create exports.make
			create features.make
		end

feature -- Access

	comment: STRING
			-- Feature group comment

	exports: LINKED_LIST [STRING]
			-- Class names in export list of this group.

	features: LINKED_LIST [EIFFEL_FEATURE]
			-- Features in this group.

feature -- Status setting

	set_comment (new_comment: like comment) is
			-- Set the comment for this feature group.
		require
			new_comment_exists: new_comment /= Void
		do
			comment := new_comment
		end

	add_export (class_name: STRING) is
			-- Add 'class_name' to export list for this group.
		require
			class_name_exists: class_name /= Void
		do
			exports.extend (class_name)
		end

	add_feature (new_feature: EIFFEL_FEATURE) is
			-- Add 'new_feature' to the features of this group.
		require
			new_feature_exists: new_feature /= Void
		do
			features.extend (new_feature)
		end 

feature -- Basic operations

	write (output: IO_MEDIUM) is
			-- Print code representation of this feature group to 'output'
		do
			write_header (output)
			write_features (output)
		end

feature {NONE} -- Implementation

	write_header (output: IO_MEDIUM) is
		do
			output.put_string ("feature ")
			if not exports.empty then
				write_exports (output)
			end
			output.put_string (" -- " + comment)
			output.put_new_line
			output.put_new_line
		end

	write_exports (output: IO_MEDIUM) is
		do
			output.put_string ("{")
			from
				exports.start
			until
				exports.off
			loop
				output.put_string (exports.item)
				if not exports.islast then
					output.put_string (", ")
				end
				exports.forth
			end
			output.put_string ("}")
		end

	write_features (output: IO_MEDIUM) is
		do
			from
				features.start
			until
				features.off
			loop
				features.item.write (output)
				features.forth
			end
		end
	
invariant
	
	comment_exists: comment /= Void
	feature_exist: features /= Void
	exports_exist:exports /= Void

end -- class EIFFEL_FEATURE_GROUP
