module AbsvalFn

# Absolute value.

export calc_absval

function calc_absval(x::Float64)
    isnan(x) && return NaN
    return abs(x)
end

function absval_table(xs::Vector{Float64})
    return [calc_absval(x) for x in xs]
end

end
