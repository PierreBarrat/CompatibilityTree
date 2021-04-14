"""
	compatibility_graph(X::Array{Bool,2})

Return compatibility graph of lines of `X`. 
"""
function compatibility_graph(X::Array{Bool,2})
	L = size(X,1)
	cg = Graph(L)
	#
	tickbox = Array{UInt8, 1}(undef, 4)
	for i in 1:L, j in (i+1):L
		if are_compatible!(tickbox, X, i, j)
			add_edge!(cg, i, j)
		end
	end
	return cg
end
compatibility_graph(tab::CharTable) = compatibility_graph(Array{Bool,2}(tab.dat'))


function are_compatible!(tickbox, X::Array{Bool,2}, i, j)
	if i < j
		tickbox[1:4] .= 0
		for m in 1:size(X,1)
			if !X[i,m]
				if !X[j,m]
					tickbox[1] = 1
				else
					tickbox[2] = 1
				end
			else
				if !X[j,m]
					tickbox[3] = 1
				else
					tickbox[4] = 1
				end
			end
			if sum(tickbox) == 4
				return false
			end
		end
		return true
	elseif i == j 
		return true
	else
		return are_compatible!(tickbox, X, j, i)
	end
end