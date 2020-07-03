using Primes

"""
Find all divisors of n

```julia-repl
julia> sort(collect(divisors(12)))
6-element Array{Int64,1}:
  1
  2
  3
  4
  6
 12
```
"""
divisors = function(n)
    f = factor(n)
    eachpower = (0:k for k in values(f))
    powers = Iterators.product(eachpower...)
    div = (prod(keys(f) .^ p) for p in powers)
    #Iterators.flatten(div)
    div
end


"""
Sum of the proper divisors of n

```julia-repl
julia> sum_divisors(220)
284
```
"""
sum_divisors = function(n)
    sum(divisors(n)) - n
end
