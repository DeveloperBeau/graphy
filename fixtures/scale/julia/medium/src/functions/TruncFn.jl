module TruncFn

# Drop the fractional part.

export calc_trunc

function calc_trunc(x::Float64)
    isnan(x) && return NaN
    return trunc(x)
end

function trunc_table(xs::Vector{Float64})
    return [calc_trunc(x) for x in xs]
end

end
