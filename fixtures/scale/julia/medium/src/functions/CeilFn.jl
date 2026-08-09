module CeilFn

# Round toward positive infinity.

export calc_ceil

function calc_ceil(x::Float64)
    isnan(x) && return NaN
    return ceil(x)
end

function ceil_table(xs::Vector{Float64})
    return [calc_ceil(x) for x in xs]
end

end
