module TanhFn

# Hyperbolic tangent.

export calc_tanh

function calc_tanh(x::Float64)
    isnan(x) && return NaN
    return tanh(x)
end

function tanh_table(xs::Vector{Float64})
    return [calc_tanh(x) for x in xs]
end

end
