module SquareFn

# Second power.

export calc_square

function calc_square(x::Float64)
    isnan(x) && return NaN
    return x * x
end

function square_table(xs::Vector{Float64})
    return [calc_square(x) for x in xs]
end

end
