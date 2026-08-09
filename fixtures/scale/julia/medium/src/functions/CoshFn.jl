module CoshFn

# Hyperbolic cosine.

export calc_cosh

function calc_cosh(x::Float64)
    isnan(x) && return NaN
    return cosh(x)
end

function cosh_table(xs::Vector{Float64})
    return [calc_cosh(x) for x in xs]
end

end
