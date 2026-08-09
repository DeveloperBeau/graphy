module ExpFn

# Natural exponent.

export calc_exp

function calc_exp(x::Float64)
    isnan(x) && return NaN
    return exp(x)
end

function exp_table(xs::Vector{Float64})
    return [calc_exp(x) for x in xs]
end

end
