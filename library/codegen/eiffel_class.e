indexing
	description: "Objects that represent an Eiffel code class"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_CLASS

inherit

	EIFFEL_CODE

creation

	make

feature -- Initialization

	make (class_name: like name) is
			-- Create new code class with 'name'
		require
			class_name_exists: class_name /= Void
		do
			set_name (class_name)
			create parents.make
			create creation_procedure_names.make
			create feature_groups.make
		end

feature -- Access

	name: STRING
			-- Class name

	parents: DS_LINKED_LIST [STRING]
			-- Class parents

	creation_procedure_names: DS_LINKED_LIST [STRING]
			-- Creation procedure names

	feature_groups: DS_LINKED_LIST [EIFFEL_FEATURE_GROUP]
			-- Feature groups

feature -- Status setting

	set_name (new_name: like name) is
			-- Set the class name
		require
			new_name_exists: new_name /= Void
		do
			name := new_name
		end

	add_parent (new_parent: STRING) is
			-- Add 'new_parent' to parents
		require
			new_parent_exists: new_parent /= Void
		do
			parents.force_last (new_parent)
		end

	add_creation_procedure_name (new_name: STRING) is
			-- Add 'new_name' as the name of a creation procedure.
		require
			new_name_exists: new_name /= Void
		do
			creation_procedure_names.force_last (new_name)
		end

	add_feature_group (new_group: EIFFEL_FEATURE_GROUP) is
			-- Add 'new_group' to the feature groups of this class.
		require
			new_group_exists: new_group /= Void
		do
			feature_groups.force_last (new_group)
		end

feature -- Basic operations

	write (output: IO_MEDIUM) is
			-- Print source code representation of this class
		do
			write_header (output)
			if not parents.is_empty then	
				write_parents (output)
			end
			if not creation_procedure_names.is_empty then
				write_creation_names (output)
			end
			if not feature_groups.is_empty then
				write_feature_groups (output)
			end
			write_end (output)
		end

feature {NONE} -- Implementation

	write_header (output: IO_MEDIUM) is
		do
			output.put_string ("class " + name)
			output.put_new_line
			output.put_new_line
		end

	write_parents (output: IO_MEDIUM) is
		do
			output.put_string ("inherit")
			output.put_new_line
			output.put_new_line
			from
				parents.start
			until
				parents.off
			loop
				output.put_string ("%T" + parents.item_for_iteration)
				output.put_new_line
				parents.forth
			end
			output.put_new_line
		end

	write_creation_names (output: IO_MEDIUM) is
		do
			output.put_string ("creation")
			output.put_new_line
			output.put_new_line
			from
				creation_procedure_names.start
			until
				creation_procedure_names.off
			loop
				output.put_string ("%T" + creation_procedure_names.item_for_iteration)
				if not creation_procedure_names.is_last then
					output.put_string (", ")
				else
					output.put_new_line
				end
				creation_procedure_names.forth
			end
			output.put_new_line
		end

	write_feature_groups (output: IO_MEDIUM) is
		do
			from
				feature_groups.start
			until
				feature_groups.off
			loop
				feature_groups.item_for_iteration.write (output)
				feature_groups.forth
			end
		end

	write_end (output: IO_MEDIUM) is
		do
			output.put_string ("end -- class " + name)
			output.put_new_line
		end

invariant

	name_exists: name /= Void
	parents_exists: parents /= Void
	creation_procedure_names_exists: creation_procedure_names /= Void
	feature_groups_exist: feature_groups /= Void

end -- class EIFFEL_CLASS
