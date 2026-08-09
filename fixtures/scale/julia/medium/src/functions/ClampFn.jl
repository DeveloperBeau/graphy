module ClampFn

export calc_clamp

function calc_clamp(x::Float64, low::Float64, high::Float64)
    low <= high || throw(ArgumentError("empty range"))
    x < low && return low
    x > high && return high
    return x
end

end
