using Primes

function trifactorfastest()
    # My fastest, anyway!
    
    function countfactors(n)
        primefactorization = factor(Dict,n)         # By setting type = Dict, we separate primes and corresponding (nonzero) exponents in key,value pairs
        v=values(primefactorization)                # Take exponents only, in a vector.
        powerof2 = get(primefactorization, 2, 0)
        return n, prod(i+1 for i in v), powerof2    # n, number of factors of n, highest power of 2 that divides n
    end

	# Instead of generating and counting factors of the triangular number T(n) for each each n, we use the formula T(n)=n*(n+1)÷2.
	# When n is incremented, we can re-use the factorization data of n+1.
	# For relatively prime a,b, the "number of factors" function is multiplicative.
	# But dividing an even number m by 2 yields a number with k/(k+1) times as many factors, where k is the power of 2 in the prime factorization of m.

    n1=(2,2,1)                        	# 3-tuple (integer, number of factors, power of 2 in prime factorization)
    n2=(3,2,0)
    maxfactorcount=2
	
    while maxfactorcount<500
         								
        twos=n1[3]+n2[3]				# n1[1] and n2[1] are adjacent integers, so one of them is odd, and this sum is the highest power of 2
										# that divides their product.
        twosfrac = [twos,twos + 1] 		# numerator, denominator of the scaling fraction
														
        Tfactors = n1[2]*n2[2]*twosfrac[1]÷twosfrac[2]
        maxfactorcount=max(maxfactorcount, Tfactors)

        n1 = n2
        n2 = countfactors(n2[1]+1)
    end

    T=n1[1]*(n1[1]-1)÷2					# As we've already incremented before detecting stopping condition.
    println("$T has $(maxfactorcount) factors.")

end

using BenchmarkTools
@benchmark trifactorfastest()

#=
BenchmarkTools.Trial: 
  memory estimate:  15.74 MiB
  allocs estimate:  128364
  --------------
  minimum time:     8.923 ms (0.00% GC)
  median time:      14.716 ms (0.00% GC)
  mean time:        14.929 ms (10.30% GC)
  maximum time:     61.385 ms (44.72% GC)
  --------------
  samples:          335
  evals/sample:     1
=#
