indexing
	description: "Objects that can stream a DOM as a string"
	date: "$Date$"
	revision: "$Revision$"

class
	DOM_WRITER

inherit
	
feature -- Transformation

	to_string (node: DOM_NODE): STRING is
			-- Recursively stream 'node' as a string.
		require
			node_exists: node /= Void
		do
			Result := to_string_recurse (node, 0, "");
		ensure
			stream_exists: Result /= Void
		end

feature {NONE} -- Implementation

	to_string_recurse (node: DOM_NODE; level: INTEGER; str: STRING): STRING is
			-- Recursive routine to stream a dom as a string
		require
			node_exists: node /= Void
			str_exists: str /= Void
			positive_level: level >= 0
		local 
			children: DOM_NODE_LIST
			i: INTEGER
		do
			Result := str
			Result.append (make_indent (level))
			Result.append (node.output)
			Result.append ("%R%N")
			children := node.child_nodes
			if children /= Void then
				from
				variant
					children.length - i
				until
					i >= children.length
				loop
					Result.append (to_string_recurse (children.item (i), level + 1, str))
					i := i + 1
				end
			end
		ensure 
			result_exists: Result /= Void
		end
			
	make_indent (level: INTEGER): STRING is
			-- Create indentation string for 'level'
		require
			positive_level: level >= 0
		do
			create Result.make (level)
			if level > 0 then
				Result.fill ("%T")
			end
		ensure
			result_exists: Result /= Void
			result_level_size: Result.count = level
		end
		
end -- class DOM_WRITER
