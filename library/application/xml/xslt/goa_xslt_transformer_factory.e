indexing
	description: "A factory for creating common XSLT transformers"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	copyright: ""

class
	GOA_XSLT_TRANSFORMER_FACTORY
	
inherit
	
	XM_SHARED_CATALOG_MANAGER
	XM_XPATH_SHARED_CONFORMANCE
	XM_XSLT_TRANSFORMER_FACTORY
	KL_SHARED_EXCEPTIONS
	
creation
	
	make_without_configuration
	
feature
	
	new_string_transformer_from_file_name (new_file_name: STRING): GOA_XSLT_STRING_TRANSFORMER is
			-- Create a new transformer given the name of the file containing the stylesheet
			-- Call this from a once function to improve performance as the stylesheet is then
			-- Compiled only once (the first time it is called)
		require
			valid_new_file_name: new_file_name /= Void
			valid_new_file_name: True -- new_file_name represents an existing file containing a valid XSLT stylesheet
		local
			xslt_configuration: XM_XSLT_CONFIGURATION
			stylesheet: XM_XSLT_STYLESHEET_COMPILER
			stylesheet_source: XM_XSLT_URI_SOURCE
			resolver_scheme: STRING
		do
				conformance.set_basic_xslt_processor
					-- Perhaps this shouldn't be here; and a precondition of conformance_set should be used instead
				create xslt_configuration.make_with_defaults
				create stylesheet.make (xslt_configuration)
				create stylesheet_source.make ("file://" + new_file_name)
--				stylesheet.prepare (stylesheet_source)
--				if stylesheet.load_stylesheet_module_failed then
--					print (new_file_name + ": " + stylesheet.load_stylesheet_module_error + "%N")
--				else
				create_new_transformer (stylesheet_source)
				if was_error then
					io.put_string (new_file_name + ": " + last_error_message + "%N")
				end
				create Result.make (created_transformer)
				resolver_scheme := string_resolver.scheme
				-- Just to make sure the string_resolver is created and registered
--				end
		end
		
	string_resolver: XM_STRING_URI_RESOLVER is
			-- Resolver used to resolve strings
		once
			create Result.make
			shared_catalog_manager.bootstrap_resolver.uri_scheme_resolver.register_scheme (Result)
		end


feature {NONE} -- Creation

	make_without_configuration is
		local
			xslt_configuration: XM_XSLT_CONFIGURATION
		do
				create xslt_configuration.make_with_defaults
				make (xslt_configuration)
		end
		

end -- class GOA_XSLT_TRANSFORMER_FACTORY
