module CbrtFn

# Cube root.

export calc_cbrt

function calc_cbrt(x::Float64)
    isnan(x) && return NaN
    return cbrt(x)
end

function cbrt_table(xs::Vector{Float64})
    return [calc_cbrt(x) for x in xs]
end

end
