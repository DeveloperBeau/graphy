module Log2Fn

# Base-2 logarithm.

export calc_log2

function calc_log2(x::Float64)
    isnan(x) && return NaN
    return log2(x)
end

function log2_table(xs::Vector{Float64})
    return [calc_log2(x) for x in xs]
end

end
