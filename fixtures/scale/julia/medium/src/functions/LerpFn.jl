module LerpFn

export calc_lerp

function calc_lerp(from::Float64, to::Float64, t::Float64)
    return from + (to - from) * t
end

function lerp_seq(from::Float64, to::Float64, n::Int)
    return [calc_lerp(from, to, t) for t in range(0.0, 1.0, length = n)]
end

end
