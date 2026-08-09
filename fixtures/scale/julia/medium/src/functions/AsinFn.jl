module AsinFn

# Inverse sine.

export calc_asin

function calc_asin(x::Float64)
    isnan(x) && return NaN
    return asin(x)
end

function asin_table(xs::Vector{Float64})
    return [calc_asin(x) for x in xs]
end

end
