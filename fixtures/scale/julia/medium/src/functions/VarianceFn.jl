module VarianceFn

export calc_variance

function calc_variance(xs::Vector{Float64})
    length(xs) > 1 || throw(ArgumentError("variance needs two samples"))
    m = sum(xs) / length(xs)
    return sum((x - m)^2 for x in xs) / (length(xs) - 1)
end

end
