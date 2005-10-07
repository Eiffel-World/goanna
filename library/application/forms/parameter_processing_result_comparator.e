indexing
	description: "Compare processing order of GOA_PARAMETER_PROCESSING_RESULT objects"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_PARAMETER_PROCESSING_RESULT_COMPARATOR
	
inherit
	
	KL_COMPARATOR [GOA_PARAMETER_PROCESSING_RESULT]
	
feature
	
	less_than (u, v: GOA_PARAMETER_PROCESSING_RESULT): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			if equal (u.request_parameter.processing_order, v.request_parameter.processing_order) then
				Result := u.parameter_suffix < v.parameter_suffix
			else
				Result := u.request_parameter.processing_order < v.request_parameter.processing_order
			end
		end
	

end -- class GOA_PARAMETER_PROCESSING_RESULT_COMPARATOR
