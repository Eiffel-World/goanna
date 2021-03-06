indexing

	description: "XMLE document wrapper for Order document"
	note: "Automatically generated by Goanna XMLE"

class ORDER_XMLE

inherit

	XMLE_DOCUMENT

creation

	make

feature  -- Implementation

	bdom_file_name: STRING is "order_xmle.bdom"

feature  -- Access

	get_node_R1234: DOM_ELEMENT is
		do
			Result ?= wrapper.get_node_by_id ("R1234")
		ensure
			element_exists: Result /= Void
		end

	get_node_customer1: DOM_ELEMENT is
		do
			Result ?= wrapper.get_node_by_id ("customer1")
		ensure
			element_exists: Result /= Void
		end

end -- class ORDER_XMLE
