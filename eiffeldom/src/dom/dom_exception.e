indexing
   project: "Eiffel binding for the Level 2 Document Object Model: Core";
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_EXCEPTION

inherit

   DOM_EXCEPTION_CODE

feature

   code: INTEGER is
         -- An integer indicating the type of error generated
      deferred
      end

end -- class DOM_EXCEPTION
