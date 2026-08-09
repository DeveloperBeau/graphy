module SinFn

# Sine.

export calc_sin

function calc_sin(x::Float64; degrees::Bool = false)
    v = degrees ? x * pi / 180 : x
    return sin(v)
end

function sin_table(xs::Vector{Float64})
    return [calc_sin(x) for x in xs]
end

end
