indexing
   project: "Eiffel binding for the Level 2 Document Object Model: Core";
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_NODE_TYPE

feature -- Constants

   Element_node: INTEGER is 1
         -- The node is an Element

   Attribute_node: INTEGER is 2
         -- The node is an Attr

   Text_node: INTEGER is 3
         -- The node is a Text

   Cdata_section_node: INTEGER is 4
         -- The node is a CDATASection

   Entity_reference_node: INTEGER is 5
         -- The node is an EntityReference

   Entity_node: INTEGER is 6
         -- The node is an Entity

   Processing_instruction_node: INTEGER is 7
         -- The node is a ProcessingInstruction

   Comment_node: INTEGER is 8
         -- The node is a Comment

   Document_node: INTEGER is 9
         -- The node is a Document

   Document_type_node: INTEGER is 10
         -- The node is a DocumentType

   Document_fragment_node: INTEGER is 11
         -- The node is a DocumentFragment

   Notation_node: INTEGER is 12
         -- The node is a Notation

end -- class DOM_NODE_TYPE
