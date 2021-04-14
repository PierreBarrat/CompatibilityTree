export max_compatibility_splits

function max_compatibility_splits(tab::CharTable)
	cg = compatibility_graph(tab)
	clique = sort(LightGraphs.maximal_cliques(cg), by=x->length(x), rev=true)[1]
	return tree_popping(tab, clique)
end

function tree_popping(tab::CharTable, sites)
	S = TreeTools.SplitList(tab.labels)
	for i in sites
		push!(S.splits, get_split(tab.dat, i))
	end
	sort!(S.splits, by=x->x.dat)
	return S
end

function get_split(X, i)
	s = TreeTools.Split(size(X,1))
	@views for (m,x) in enumerate(X[:,i])
		if x
			s.dat[m] = true
		end
	end
	return s
end