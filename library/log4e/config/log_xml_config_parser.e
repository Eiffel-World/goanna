indexing
	description: "Logging XML configuration parser."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOG_XML_CONFIG_PARSER

inherit
	
	LOG_SHARED_LOG_LOG
		export
			{NONE} all
		end
	
	LOG_PRIORITY_CONSTANTS
		export
			{NONE} all
		end
		
	LOG_XML_CONFIG_CONSTANTS
		export
			{NONE} all
		end
		
create

	make

feature -- Initialisation

	make (config_file_name: STRING) is
			-- Create a new config parser that will parse the file
			-- named 'config_file_name'.
		require
			config_file_name_exists: config_file_name /= Void
		do
			create file_name.make_from_string (config_file_name)
			create category_elements.make_default
			create appenders.make_default
			parse
		end
		
feature -- Parsing

	parse is
			-- Parse specified configuration file and create appropriate
			-- Log4E topology. Make resulting heirarchy available in 
			-- 'hierarchy'.
		do
			create parser.make
			debug ("log4e_config")
				Internal_log.warn ("Parsing file: " + file_name.out + "...%R%N")
			end
			parser.parse_from_file_name (file_name)
			if parser.last_error = parser.Xml_err_none then
				debug ("log4e_config")
					display_dom_tree (parser.document)
				end
				process_config_tree (parser.document)
			else
				display_parser_error
			end
		end
	
	hierarchy: LOG_HIERARCHY
			-- Configured logging hierarchy
			
feature {NONE} -- Implementation

	parser: DOM_TREE_BUILDER

	file_name: UCSTRING
			-- Name of file to parse.
	
	display_parser_error is
			-- Output parsing error
		do
			internal_log.error ("XML parser error: " + parser.last_error_description
				+ " (" + parser.last_error_extended_description + ")")
			internal_log.error ("At position: " + parser.position.out)
		end

	display_dom_tree (document: DOM_DOCUMENT) is
			-- Display dom tree to standard out.
		require
			document_exists: document /= Void	
		local
			writer: DOM_SERIALIZER
		do
			writer := serializer_factory.serializer_for_document (document)
			writer.set_output (io.output)
			writer.serialize (document)		
		end
	
	serializer_factory: DOM_SERIALIZER_FACTORY is
		once
			create Result
		end

	appenders: DS_HASH_TABLE [LOG_APPENDER, STRING]
			-- Collection of named appenders
		
	category_elements: DS_HASH_TABLE [DOM_ELEMENT, STRING]
			-- Collection of category elements for post processing (after all
			-- appenders have been created so that appender references can 
			-- be resolved.
		
	root_element: DOM_ELEMENT
			-- Root element held for post processing all appender refs.
			
	process_config_tree (document: DOM_DOCUMENT) is
			-- Process configuration DOM tree.
		require
			document_exists: document /= Void
		local
			number_children, index: INTEGER
			child_nodes: DOM_NODE_LIST
			element: DOM_ELEMENT
		do
			-- process the root element
			process_root (document.document_element)
			if hierarchy /= Void then		
				-- iterate through top level elements and process according to type,
				-- ignoring root as it is already done
				from
					child_nodes := document.document_element.child_nodes
					number_children := child_nodes.length
					index := 0
				variant
					number_children - index + 1
				until		
					index >= number_children
				loop
					element ?= child_nodes.item (index)
					check
						node_is_element: element /= Void
					end
					process_element (element)
					index := index + 1
				end
			end
			post_process_categories
			post_process_root	
		end
		
	process_element (element: DOM_ELEMENT) is
			-- Determine type of element and process
		require
			element_exists: element /= Void
		local
			name: DOM_STRING
		do
			name := element.node_name
			if name.is_equal (Appender_element_name) then
				process_appender (element)
			elseif name.is_equal (Category_element_name) then
				process_category (element)
			elseif name.is_equal (Root_element_name) then
				-- ignore, already processed
			else
				internal_log.error ("Unknown top level element type: " + name.out)
			end
		end
		
	process_appender (element: DOM_ELEMENT) is
			-- Process an appender configuration element
		require
			element_exists: element /= Void
		local
			name, type: DOM_STRING
		do
			if element.has_attribute_ns (Empty_namespace_uri, Name_attribute) then
				name := element.get_attribute_ns (Empty_namespace_uri, Name_attribute)
				if element.has_attribute_ns (Empty_namespace_uri, Type_attribute) then
					type := element.get_attribute_ns (Empty_namespace_uri, Type_attribute)
					create_appender (name, type, element)
				else
					internal_log.error ("Appender type attribute not found.")
				end
			else
				internal_log.error ("Appender name attribute not found.")
			end
		end
	
	create_appender (name, type: DOM_STRING; element: DOM_ELEMENT) is
			-- Create an appender of the specified 'type' and store
			-- in 'appenders' indexed by 'name'
		require
			name_exists: name /= Void
			type_exists: type /= Void
			element_exists: element /= Void
		local
			appender: LOG_APPENDER
		do
			if type.is_equal (Stdout_appender_type) then
				create {LOG_STDOUT_APPENDER} appender.make (name.out)
			elseif type.is_equal (Stderr_appender_type) then
				create {LOG_STDERR_APPENDER} appender.make (name.out)
			elseif type.is_equal (File_appender_type) then
				appender := create_file_appender (name, element)
			elseif type.is_equal (Rollingfile_appender_type) then
				appender := create_rolling_file_appender (name, element)
			end	
			if appender /= Void then
				appenders.force (appender, name.out)	
			end
		end

	create_file_appender (name: DOM_STRING; element: DOM_ELEMENT): LOG_APPENDER is
			-- Create a file appender using parameters in 'element'
		require
			name_exists: name /= Void
			element_exists: element /= Void
		local
			file, append: STRING
		do
			-- retrieve mandatory file name param
			file := retrieve_param_value (Filename_param_name, element)
			if file /= Void then
				-- retrieve optional append param 
				append := retrieve_param_value (Append_param_name, element)
				if append /= Void and then append.is_equal ("true") then
					create {LOG_FILE_APPENDER} Result.make (file, True)
				else
					create {LOG_FILE_APPENDER} Result.make (file, False)
				end
			else
				internal_log.error ("File appender 'filename' attribute not found.")
			end
		end
	
	create_rolling_file_appender (name: DOM_STRING; element: DOM_ELEMENT): LOG_APPENDER is
			-- Create a rolling file appender using parameters in 'element'
		require
			name_exists: name /= Void
			element_exists: element /= Void
		local
			file, append: STRING
			max_size, number_of_backups: INTEGER_REF
		do
			-- retrieve mandatory file name param
			file := retrieve_param_value (Filename_param_name, element)
			if file /= Void then
				-- retrieve mandatory max_size param
				max_size := retrieve_integer_param_value (Maxsize_param_name, element)
				if max_size /= Void then
					-- retrieve mandatory number_of_backups param
					number_of_backups := retrieve_integer_param_value (Numbackups_param_name, element)
					if number_of_backups /= Void then
						-- retrieve optional append param 
						append := retrieve_param_value (Append_param_name, element)
						if append /= Void and then append.is_equal ("true") then
							create {LOG_ROLLING_FILE_APPENDER} Result.make (file, max_size.item, number_of_backups.item, True)
						else
							create {LOG_ROLLING_FILE_APPENDER} Result.make (file, max_size.item, number_of_backups.item, False)
						end	
					else
						internal_log.error ("File appender 'numbackups' attribute not found.")
					end
				else
					internal_log.error ("File appender 'maxsize' attribute not found.")
				end
			else
				internal_log.error ("File appender 'filename' attribute not found.")
			end
		end	
		
	retrieve_param_value (name: DOM_STRING; parent: DOM_ELEMENT): STRING is
			-- Locate child param element with specified name. Return value
			-- if found, Void otherwise.
		require
			element_exists: parent /= Void
		local
			number_children, index: INTEGER
			child_nodes: DOM_NODE_LIST
			element: DOM_ELEMENT
			param_name: DOM_STRING
		do
			-- iterate through child elements and search for named parameter element
			from
				child_nodes := parent.child_nodes
				number_children := child_nodes.length
				index := 0
			variant
				number_children - index + 1
			until		
				index >= number_children or Result /= Void
			loop
				element ?= child_nodes.item (index)
				check
					node_is_element: element /= Void
				end
				if element.node_name.is_equal (Param_element_name) then
					-- check for a name attribute
					if element.has_attribute_ns (Empty_namespace_uri, Name_attribute) then
						param_name := element.get_attribute_ns (Empty_namespace_uri, Name_attribute)
						if param_name.is_equal (name) then
							-- retrieve the value attribute
							if element.has_attribute_ns (Empty_namespace_uri, Value_attribute) then
								Result := element.get_attribute_ns (Empty_namespace_uri, Value_attribute).out
							else
								internal_log.error ("Parameter element value attribute not found.")
							end 
						end
					else
						internal_log.error ("Parameter element name attribute not found.")
					end
				end
				index := index + 1
			end			
		end
		
	retrieve_integer_param_value (name: DOM_STRING; parent: DOM_ELEMENT): INTEGER_REF is
			-- Locate an integer child param element with specified name. Return value
			-- if found, Void otherwise.
		require
			element_exists: parent /= Void
		local
			value: STRING
		do
			value := retrieve_param_value (name, parent)
			if value /= Void then
				if value.is_integer then
					create Result
					Result.set_item (value.to_integer)		
				else
					internal_log.error ("Invalid value found for parameter " + name.out)
				end	
			end
		end
		
	process_category (element: DOM_ELEMENT) is
			-- Process a category element
		require
			element_exists: element /= Void
		local
			name, type: DOM_STRING
		do
			if element.has_attribute_ns (Empty_namespace_uri, Name_attribute) then
				name := element.get_attribute_ns (Empty_namespace_uri, Name_attribute)
				category_elements.force (element, name.out)
			else
				internal_log.error ("Category name attribute not found.")
			end			
		end

	post_process_categories is
			-- Process all category elements to resolve appender references
		local
			cursor: DS_HASH_TABLE_CURSOR [DOM_ELEMENT, STRING]
		do
			from
				cursor := category_elements.new_cursor
				cursor.start
			until
				cursor.off
			loop
				post_process_category (cursor.key, cursor.item)
				cursor.forth
			end
		end
		
	post_process_category (name: STRING; element: DOM_ELEMENT) is
			-- Process a category element and create appropriate category object
		local
			category: LOG_CATEGORY
			priority: LOG_PRIORITY
			number_children, index: INTEGER
			child_nodes: DOM_NODE_LIST
			child: DOM_ELEMENT
		do
			category := hierarchy.category (name)
			-- search for optional priority attribute
			if element.has_attribute_ns (Empty_namespace_uri, Priority_attribute) then
				priority := create_priority (element.get_attribute_ns (Empty_namespace_uri, Priority_attribute))
				if priority /= Void then
					category.set_priority (priority)
				end
			end
			-- search for optional appender refs
			from
				child_nodes := element.child_nodes
				number_children := child_nodes.length
				index := 0
			variant
				number_children - index + 1
			until		
				index >= number_children
			loop
				child ?= child_nodes.item (index)
				check
					node_is_element: child /= Void
				end
				if child.node_name.is_equal (Appenderref_element_name) then
					-- search for mandatory ref attribute
					if child.has_attribute_ns (Empty_namespace_uri, Ref_attribute) then
						category.add_appender (appenders.item (child.get_attribute_ns (Empty_namespace_uri, Ref_attribute).out))
					else
						internal_log.error ("Appender reference 'ref' attribute not found.")
					end
				else
					internal_log.error ("Invalid child node within category: " + name)
				end
				index := index + 1
			end
		end
		
	create_priority (priority_name: DOM_STRING): LOG_PRIORITY is
			-- Create a priority object representing the named priority. 
			-- Return Void if not a valid priority
		require
			priority_name_exists: priority_name /= Void
		local
			upper_name: STRING
		do
			upper_name := priority_name.out
			upper_name.to_upper
			--| TODO: implement this as a factory
			if upper_name.is_equal ("DEBUG") then
				Result := Debug_p
			elseif upper_name.is_equal ("INFO") then
				Result := Info_p
			elseif upper_name.is_equal ("WARN") then
				Result := Warn_p
			elseif upper_name.is_equal ("ERROR") then
				Result := Error_p
			elseif upper_name.is_equal ("FATAL") then
				Result := Fatal_p
			end
		end
		
	process_root (parent: DOM_ELEMENT) is
			-- Process a root element
		require
			element_exists: parent /= Void
		local
			number_children, index: INTEGER
			child_nodes: DOM_NODE_LIST
			element: DOM_ELEMENT
			done: BOOLEAN
			priority: LOG_PRIORITY
		do
			from
				child_nodes := parent.child_nodes
				number_children := child_nodes.length
				index := 0
			variant
				number_children - index + 1
			until		
				index >= number_children or done
			loop
				element ?= child_nodes.item (index)
				check
					node_is_element: element /= Void
				end
				if element.node_name.is_equal (Root_element_name) then
					-- this is the root, get the priority
					if element.has_attribute_ns (Empty_namespace_uri, Priority_attribute) then
						priority := create_priority (element.get_attribute_ns (Empty_namespace_uri, Priority_attribute))
						if priority /= Void then
							create hierarchy.make (priority)
							-- store the root element for post processing
							root_element := element
						else
							internal_log.error ("Invalid root category priority.")
						end
					else
						internal_log.error ("Root category priority attribute not found.")
					end
					done := True
				end
				index := index + 1
			end
		end
		
	post_process_root is
			-- Process a category element and create appropriate category object
		require
			root_element_exists: root_element /= Void
		local
			number_children, index: INTEGER
			child_nodes: DOM_NODE_LIST
			child: DOM_ELEMENT
		do
			-- search for optional appender refs
			from
				child_nodes := root_element.child_nodes
				number_children := child_nodes.length
				index := 0
			variant
				number_children - index + 1
			until		
				index >= number_children
			loop
				child ?= child_nodes.item (index)
				check
					node_is_element: child /= Void
				end
				if child.node_name.is_equal (Appenderref_element_name) then
					-- search for mandatory ref attribute
					if child.has_attribute_ns (Empty_namespace_uri, Ref_attribute) then
						hierarchy.root.add_appender (appenders.item (child.get_attribute_ns (Empty_namespace_uri, Ref_attribute).out))
					else
						internal_log.error ("Appender reference 'ref' attribute not found for root.")
					end
				else
					internal_log.error ("Invalid child node within root.")
				end
				index := index + 1
			end
		end
		
end -- class LOG_XML_CONFIG_PARSER
