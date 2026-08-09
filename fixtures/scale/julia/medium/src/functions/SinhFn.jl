module SinhFn

# Hyperbolic sine.

export calc_sinh

function calc_sinh(x::Float64)
    isnan(x) && return NaN
    return sinh(x)
end

function sinh_table(xs::Vector{Float64})
    return [calc_sinh(x) for x in xs]
end

end
