indexing

	description: "Test SOAP Faults"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "test SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Colin Adams <colin@colina.demon.co.uk>"
	copyright: "Copyright (c) 2005 Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

	
deferred class SOAP_TEST_FAULT

inherit

	TS_TEST_CASE

feature -- Test

	test_parse_with_detail is
			-- Test parse of test1.xml.
		local
			a_processor: GOA_SOAP_PROCESSOR
		do
			create a_processor.make
			a_processor.process (fault_message) 
			assert ("Parse sucessful", a_processor.is_build_sucessful)
		end

	fault_message: STRING is
			-- Example env:Fault
		once
			Result := "[
<?xml version="1.0" encoding="UTF-8" ?>
<env:Envelope xmlns:env="http://www.w3.org/2003/05/soap-envelope"
              xmlns:m="http://www.example.org/timeouts"
              xmlns:xml="http://www.w3.org/XML/1998/namespace">
<!-- Taken from: SOAP Version 1.2 Part 1: Messaging Framework, example 4 -->
 <env:Body>
  <env:Fault>
   <env:Code>
     <env:Value>env:Sender</env:Value>
     <env:Subcode>
      <env:Value>m:MessageTimeout</env:Value>
     </env:Subcode>
   </env:Code>
   <env:Reason>
     <env:Text xml:lang="en">Sender Timeout</env:Text>
   </env:Reason>
   <env:Detail>
     <m:MaxTime>P5M</m:MaxTime>
   </env:Detail>    
  </env:Fault>
 </env:Body>
</env:Envelope>

						   ]"
		end

end -- class SOAP_TEST_FAULT
