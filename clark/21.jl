using Primes

"""
Sum of the proper divisors of n

```julia-repl
julia> sum_divisors(220)
284
```
"""
sum_divisors = function(n)
    f = factor(n)
    fl = []
    for (fac, mul) in f
        for i in 1:mul
            push!(fl, fac)
        end
    end
end
