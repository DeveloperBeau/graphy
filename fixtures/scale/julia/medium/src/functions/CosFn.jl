module CosFn

# Cosine.

export calc_cos

function calc_cos(x::Float64; degrees::Bool = false)
    v = degrees ? x * pi / 180 : x
    return cos(v)
end

function cos_table(xs::Vector{Float64})
    return [calc_cos(x) for x in xs]
end

end
