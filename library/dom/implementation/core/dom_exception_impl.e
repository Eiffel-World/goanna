indexing
   project: "Eiffel binding for the Level 2 Document Object Model: Core";
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_EXCEPTION_IMPL

inherit

   DOM_EXCEPTION

feature

   code: INTEGER 
         -- An integer indicating the type of error generated

end -- class DOM_EXCEPTION_IMPL
