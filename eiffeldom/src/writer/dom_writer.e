indexing
	description: "Objects that can stream a DOM as a string"
	date: "$Date$"
	revision: "$Revision$"

class
	DOM_WRITER
	
feature -- Transformation

	to_string (node: DOM_NODE): UCSTRING is
			-- Recursively stream 'node' as a string.
		require
			node_exists: node /= Void
		do
			Result := to_string_recurse (node, 0)
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Implementation

	to_string_recurse (node: DOM_NODE; level: INTEGER): UCSTRING is
			-- Recursive routine to stream a dom as a string
		require
			node_exists: node /= Void
			positive_level: level >= 0
		local 
			children: DOM_NODE_LIST
			i: INTEGER
		do
			Result := node.output_indented (level)
			Result.append_string ("%R%N")
			children := node.child_nodes
			if children /= Void then
				from
				variant
					children.length - i
				until
					i >= children.length
				loop
					Result.append_ucstring (to_string_recurse (children.item (i), level + 1))
					i := i + 1
				end
			end
		ensure 
			result_exists: Result /= Void
		end
					
end -- class DOM_WRITER
