module AcosFn

# Inverse cosine.

export calc_acos

function calc_acos(x::Float64)
    isnan(x) && return NaN
    return acos(x)
end

function acos_table(xs::Vector{Float64})
    return [calc_acos(x) for x in xs]
end

end
