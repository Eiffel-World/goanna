indexing
	description: "Objects that test GOA_FAST_CGI_REQUEST"
	author: "Neal Lester"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	FAST_CGI_TEST_REQUEST

inherit

	TS_TEST_CASE

feature

	test_as_fast_cgi_string is
		local
			request: GOA_FAST_CGI_REQUEST
			parameters: DS_HASH_TABLE [STRING, STRING]
		do
			create request.make
			create parameters.make_equal (10)
			parameters.force ("Name1", "Value1")
			parameters.force ("Name2", "Value2")
			parameters.force ("Name3", "Value3")
			parameters.force ("Name4", "Value4")
			parameters.do_all_with_key (agent add_raw_parameter_to_request (?,?, request))
			request.process_parameter_raw_data
			assert ("request parameters 1", tables_equal (parameters, request.parameters))
			create request.make
			create parameters.make_equal (10)
			parameters.force ("Name1", "Value1")
			parameters.force ("Name2", "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789")
			parameters.force ("012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789", "Value3")
			parameters.force ("BB012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789", "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789")
			-- Edge Cases short value vs. long value
			parameters.force ("125", "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345")
			parameters.force ("126", "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456")
			parameters.force ("127", "01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567")
			parameters.force ("128", "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678")
			parameters.force ("Name5", "Value5")
			parameters.do_all_with_key (agent add_raw_parameter_to_request (?,?, request))
			request.process_parameter_raw_data
			assert ("request parameters 2", tables_equal (parameters, request.parameters))


		end

	add_raw_parameter_to_request (a_value, a_name: STRING; a_request: GOA_FAST_CGI_REQUEST) is
		require
			valid_a_name: a_name /= Void
			valid_a_value: a_value /= Void
			valid_a_request: a_request /= Void
		do
			a_request.add_parameter_to_raw_content (a_name, a_value)
		end

	tables_equal (table_1, table_2: DS_HASH_TABLE [STRING, STRING]): BOOLEAN
			-- Are contents of table_1 and table_2 equal?
		require
			valid_table_1: table_1 /= Void
			valid_table_2: table_2 /= Void
		local
			equality_tester: KL_EQUALITY_TESTER [STRING]
		do
			create equality_tester
			table_2.set_equality_tester (equality_tester)
			Result := table_1.count = table_2.count
			from
				table_1.start
			until
				table_1.after or not Result
			loop
				Result := table_2.has (table_1.key_for_iteration) and then equal (table_2.item (table_1.key_for_iteration), table_1.item_for_iteration)
				table_1.forth
			end
		end

end
