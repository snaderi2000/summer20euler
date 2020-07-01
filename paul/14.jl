function collatzbin2()

    nextnode(n) = n&1==1 ? n + n<<1 + 1 : n>>1
		# The definition above is equivalent to
        # n%2==1 ? 3n+1 : n÷2
		# but, in this program, the bitwise operations
		# make the execution twice as fast (!).

    function descent(n)
        seqlength=1
        while n>1
            n = nextnode(n)
            seqlength+=1
        end
        return seqlength
    end

    findmax([descent(i) for i in 1:1000000])
end

#=
	@benchmark collatzbin2()
	BenchmarkTools.Trial: 
	  memory estimate:  7.63 MiB
	  allocs estimate:  2
	  --------------
	  minimum time:     169.709 ms (0.00% GC)
	  median time:      170.819 ms (0.00% GC)
	  mean time:        173.539 ms (0.34% GC)
	  maximum time:     198.952 ms (0.00% GC)
	  --------------
	  samples:          29
	  evals/sample:     1
	 ___________

	 It's somewhat faster to store in a vector the sequence lengths for nodes visited,
	 and to write sequence lengths for 2^k * n, up to 1,000,000, for each n
	 visited. But my code for this is much more tangled and inelegant.
=#
