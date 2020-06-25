import Primes: factor
import Combinatorics: powerset
import IterTools: subsets

using Profile


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
    
    # ps contains 2^length(f) elements, which gets big fast.
    # I'm surprised- Combinatorics.powerset is twice as fast as IterTools.subsets
    ps = powerset(f) 
    #ps = subsets(f) 

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

@profile first_div_triangle_num()

# These profile defaults are not that helpful for end users.
# When I profile, I usually want to know just what part of the code *that I wrote* is slow.
# In this case, I suspect two potentially expensive calls:
#   1. factoring the prime
#   2. collecting the powerset
# I want to know how much time the program spends in these calls.
Profile.print(maxdepth = 15)

# All I really want to see is this:
#     ╎    ╎    ╎  27011  REPL[46]:2; first_div_triangle_num()
#    6╎    ╎    ╎   27011  REPL[46]:4; first_div_triangle_num
#    6╎    ╎    ╎    6      REPL[50]:1; count_div(::Int64)
#     ╎    ╎    ╎    2046   REPL[50]:6; count_div(::Int64)
#    2╎    ╎    ╎     2046   ...Primes/uaYlp/src/Primes.jl:340; factor
#     ╎    ╎    ╎    54     REPL[50]:7; count_div(::Int64)
#     ╎    ╎    ╎     54     @Base/array.jl:1222; pushfirst!
#     ╎    ╎    ╎    208    REPL[50]:10; count_div(::Int64)
#     ╎    ╎    ╎     208    ...torics/src/combinations.jl:274; powerset
#     ╎    ╎    ╎    24676  REPL[50]:12; count_div(::Int64)
#     ╎    ╎    ╎     24676  @Base/set.jl:21; Set
#    6╎    ╎    ╎    15     REPL[50]:13; count_div(::Int64)
#     ╎    ╎    ╎     9      @Base/set.jl:55; length
#

# There were about 25k samples inside Set that collected the powerset, 2k samples inside the call to factor().
# Thus, my inefficient use of powerset is the bottleneck in this program.
# My expectation that these were the bottlenecks was correct- the next most expensive call is pushfirst! with only 54 samples- no problem at all.

using ProfileView
@profview first_div_triangle_num()
