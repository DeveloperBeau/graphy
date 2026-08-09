module LnFn

# Natural logarithm.

export calc_ln

function calc_ln(x::Float64)
    isnan(x) && return NaN
    return log(x)
end

function ln_table(xs::Vector{Float64})
    return [calc_ln(x) for x in xs]
end

end
