module Deg2RadFn

# Degrees to radians.

export calc_deg2rad

function calc_deg2rad(x::Float64)
    isnan(x) && return NaN
    return x * pi / 180
end

function deg2rad_table(xs::Vector{Float64})
    return [calc_deg2rad(x) for x in xs]
end

end
