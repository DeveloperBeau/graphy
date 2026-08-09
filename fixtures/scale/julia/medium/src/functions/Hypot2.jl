module Hypot2

export calc_hypot2

function calc_hypot2(x::Float64, y::Float64)
    return sqrt(x * x + y * y)
end

function hypot2_table(xs::Vector{Float64}, ys::Vector{Float64})
    return [calc_hypot2(x, y) for (x, y) in zip(xs, ys)]
end

end
