struct CharTable{T} 
	dat::Array{Bool,2}
	labels::Array{T,1}
	CharTable(dat, labels::Array{T,1}) where T = (length(labels) != size(dat, 2) ? error("Number of sequences and labels differ") : new{T}(dat, labels))
end
"""
	chartable(aln; lineseq = true)
	chartable(aln, labels; lineseq=true) 
"""
function CharTable(aln; lineseq = true)
	dat = Array{Bool,2}(aln)
	labels = collect(1:size(dat,2))
	return CharTable(dat, labels)
end

