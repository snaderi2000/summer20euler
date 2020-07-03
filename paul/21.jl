# There is a lovely formula for the sum of proper divisors, but my elementary
# number theory is quite stale. So my sum of divisors function is slow.

function sumproperdivisors(n)
	F=factor(Dict,n)
	primefactorcount = length(keys(F))
    
	allprimepowers=[[p^k for k in 0:F[p]] for p in keys(F)]
    
	# The above is an array, containing a varying number of arrays, of
	# varying lengths. There should be a one-line way to iterate over this
	# collection, yielding all possible products consisting of one prime-power
	# factor selected from each inner array. But I don't know such a method,
	# so I settled on the following -- constructing the vector of divisors
	# in repeated passes.
    
	alldivisors=1
	for primepowersequence in allprimepowers
		alldivisors=[x*y for x in primepowersequence for y in alldivisors]
	end
	sum(alldivisors) - n
end

function amisum1(limit)
	# Far from optimal -- excessive calls to the sumproperdivisors function.
	amilist=[]
	for n in 2:limit-1
		s=sumproperdivisors(n)
		if s>n && sumproperdivisors(s)==n && s!=n
			push!(amilist,n)
		end
	end
	sum(amilist)+sum(sumproperdivisors(n) for n in amilist)
end
