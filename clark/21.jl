using Primes: factor

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


"""
Check if a number is amicable, using precomputed sum of proper divisors
"""
is_amicable = function(n, spd)
    m = spd[n]
    N = length(spd)
    # I've used this ternary operator a few times, it's pretty clever
    m ≤ N ? spd[m] == n : false
end


"""
Sum of all the amicable numbers less than N
"""
sum_amicable = function(N = 10000)
    possible = 2:(N-1)
    spd = sum_divisors.(possible)
    # Just to line things up
    pushfirst!(spd, 0)
    sum(n for n in possible if is_amicable(n, spd))
end


sum_amicable()
