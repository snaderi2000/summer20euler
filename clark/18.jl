# These arrays grow by appending, which can be quite expensive depending on implementation.
# We could use the file size to determine the exact size of the largest row, so that we preallocate the exact amount we need.
# No big deal for this problem though.
maxsum = function(datafile = "18example.txt")
    oldmax = [0]
    for line in eachline(datafile)
        # Wow, I like this dot append syntax to make any function become vectorized.
        weights = parse.(Int, split(line))
        newmax = similar(weights)
        for (i, wi) in enumerate(weights)
            largest_parent = if i == 1
                    # The left side of the triangle
                    oldmax[i]
                elseif i == length(weights)
                    # The right side of the triangle
                    oldmax[i-1]
                else
                    # The middle of the triangle
                    maximum(oldmax[(i-1):i])
                end
            newmax[i] = largest_parent + wi
        end
        oldmax = newmax
    end
    maximum(oldmax)
end

maxsum("18data.txt")
