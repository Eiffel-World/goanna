indexing
	description: "XMLRPC Example Client."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples xmlrpc"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_CLIENT

inherit
		
	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end
			
creation

	make

feature -- Initialization

	make is
			-- Create and initialise a new HTTP server that will listen for connections
			-- on 'port' and serving documents from 'doc_root'.
			-- Start the server
		do
			parse_arguments
			if argument_error then
				print_usage
			else
				perform_call
			end
		end

feature {NONE} -- Implementation

	host: STRING
			-- Connect host
			
	port: INTEGER
			-- Connect port
			
	argument_error: BOOLEAN
			-- Did an error occur parsing arguments?
			
	parse_arguments is
			-- Parse the command line arguments and store appropriate settings
		do
			if Arguments.argument_count < 2 then
				argument_error := True
			else
				-- parse host
				host := Arguments.argument (1)
				-- parse port
				if Arguments.argument (2).is_integer then
					port := Arguments.argument (2).to_integer
				else
					argument_error := True
				end
			end
		end

	print_usage is
			-- Display usage information
		do
			print ("Usage: xrpcclient <host> <port-number>%R%N")
		end
	
	
	perform_call is
			-- Create XRPC call and execute it.
		local
			client: XRPC_LITE_CLIENT
			call: XRPC_CALL
			v1: XRPC_SCALAR_VALUE
			ht: DS_HASH_TABLE [XRPC_VALUE, STRING]
			s1: XRPC_STRUCT_VALUE
			array: ARRAY [XRPC_VALUE]
			a1: XRPC_ARRAY_VALUE
			p1, p2: XRPC_PARAM
		do
			create call.make ("calc.plus")
			
			-- create array param
--			create array.make (1, 2)
--			create v1.make ("element 1")
--			array.put (v1, 1)
--			create v1.make ("element 2")
--			array.put (v1, 2)
--			create a1.make (array)
--			create p1.make (a1)
			
--			call.add_param (p1)

			-- create struct param
--			create ht.make (3)
--			create v1.make ("struct element 1")
--			ht.put (v1, "element 1")
--			create v1.make ("struct element 2")
--			ht.put (v1, "element 2")
--			ht.put (a1, "nested array")
--			create s1.make (ht)
--			create p2.make (s1)
			
--			call.add_param (p2)
			
			create v1.make (100.0)
			create p1.make (v1)
			call.add_param (p1)
			create v1.make (20.5)
			create p1.make (v1)
			call.add_param (p1)
			
			create client.make (host, port, "/servlet/xmlrpc")
			client.invoke (call)
			if client.invocation_ok then
				print (client.response.marshall)
			else
				debug ("xmlrpc")
					print (client.fault.marshall)
					print ("%N")
				end		
				print ("Fault received: (" + client.fault.code.out + ") " + client.fault.string)
			end
			print ("%N")
		end

end -- class XRPC_CLIENT
