function factors(n) #returns factors of a number
    arr = []
    for i in 1:floor(sqrt(n) + 1)
        if(n % i == 0)
            if(i * i == n)
                append!(arr, i);
            else
                append!(arr, [i, n /i]); 
            end
        end
    end
    return arr
end

function d(n)
    return sum(factors(n)) - n
end

function amicable(x) #returns the amicable pair of an integer, otherwise returns 0
    y = d(x) #sum of factors of x
    dy = d(y) #sum of factors of y
    if(x != y && dy == x)
        return y
    else
        return 0
    end
end

function foo()
arr = []
for i in 1:10000
    if(0 < amicable(i) < 10000)
        append!(arr, i)
    end
end
    
    return sum(arr)
end
        