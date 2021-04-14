using Test
using CompatibilityTree
using LightGraphs
using TreeTools

 
#=
Example from Felsenstein's book
=#

dat = Array{Bool,2}(
		[1 0 0 1 1 0;
		0 0 1 0 0 0;
		1 1 0 0 0 0;
		1 1 0 1 1 1;
		0 0 1 1 1 0;
		0 0 0 0 0 0]')

aln = [1 0 0 1 1 0;
		0 0 1 0 0 0;
		1 1 0 0 0 0;
		1 1 0 1 1 1;
		0 0 1 1 1 0;
		0 0 0 0 0 0]
labels = ["α", "β", "γ", "δ", "ε", "ω"]
tab = CompatibilityTree.CharTable(aln, labels)

gref = Graph(6)
add_edge!(gref, 1, 2)
add_edge!(gref, 1, 3)
add_edge!(gref, 1, 6)
add_edge!(gref, 2, 3)
add_edge!(gref, 2, 6)
add_edge!(gref, 3, 6)
add_edge!(gref, 4, 5)
add_edge!(gref, 4, 6)
add_edge!(gref, 5, 6)

Sref = TreeTools.SplitList(labels, 
	[Split([1,0,1,1,0,0]), Split([0,0,1,1,0,0]), Split([0,1,0,0,1,0]), Split([0,0,0,1,0,0])],
	ones(Bool, length(labels)), Dict{String,Split}())
sort!(Sref.splits, by=x->x.dat)

@testset "Felsenstein example (p93)" begin
	@test CompatibilityTree.compatibility_graph(dat) == gref
	@test CompatibilityTree.compatibility_graph(tab) == gref
	@test max_compatibility_splits(tab) == Sref
end

