module Log10Fn

# Base-10 logarithm.

export calc_log10

function calc_log10(x::Float64)
    isnan(x) && return NaN
    return log10(x)
end

function log10_table(xs::Vector{Float64})
    return [calc_log10(x) for x in xs]
end

end
