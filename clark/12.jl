import Primes: factor
import Combinatorics: powerset


"""
Count the number of divisors of x.
For example, 28 has 6 divisors: 1,2,4,7,14,28.

```julia-repl
julia> count_div(28)
6
```
"""
function count_div(x)
    # Here's a lazy way to do it.
    # All divisors of x are products of the prime factors.
    # Given the prime factorization, we can form the set of all products of a subset of the prime factors.
    # Finally, just count the number of elements in that set.
    f = factor(Vector, x)
    pushfirst!(f, 1)
    
    ps = powerset(f) 
    divisors = Set(prod(s) for s in ps)
    length(divisors)
end


"""
Find the first triangle number with more than n divisors.

```julia-repl
julia> first_div_triangle_num(5)
28
```
"""
function first_div_triangle_num(n = 500)
    i = 1
    ti = 1
    while count_div(ti) ≤ n
        i += 1
        ti += i
    end
    ti
end


# 0.5 second
@time first_div_triangle_num()
