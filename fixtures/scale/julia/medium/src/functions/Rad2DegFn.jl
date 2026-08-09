module Rad2DegFn

# Radians to degrees.

export calc_rad2deg

function calc_rad2deg(x::Float64)
    isnan(x) && return NaN
    return x * 180 / pi
end

function rad2deg_table(xs::Vector{Float64})
    return [calc_rad2deg(x) for x in xs]
end

end
