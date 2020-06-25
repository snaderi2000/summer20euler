using Memoize: @memoize


"""
```julia-repl
julia> collatzlength1(13)
10
```
"""
@memoize function collatzlength(n)
    if n == 1
        return 1
    end
    nn = iseven(n) ? n ÷ 2 : 3n + 1
    1 + collatzlength(nn) 
end


maxcl = function(n = 1_000_000 - 1)
    maxlen = 1
    maxi = 1
    for i in 1:n
        l = collatzlength(i)
        if maxlen < l
            maxlen = l
            maxi = i
        end
    end
    maxi, maxlen
end


@time maxcl()



# I don't like the following version.
# It's slower too.
########################################


"""
```julia-repl
julia> collatzlength1(13)
10
```
"""
@memoize function collatzlength1(n)
    if n == 1
        return (n = 1, length = 1)
    end
    nn = iseven(n) ? n ÷ 2 : 3n + 1
    lnn = collatzlength1(nn).length
    (n = n, length = 1 + lnn)
end


maxcl1 = function(n = 1_000_000 - 1)
    cl = (collatzlength1(i) for i in 1:n)
    mx = maximum(x.length for x in cl)
    first(x.n for x in cl if x.length == mx)
end


# 7.73 seconds first time
# 0.655 seconds after compilation and memoization cache is built
@time maxcl1()
