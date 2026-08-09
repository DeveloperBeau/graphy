module RoundFn

# Round half to even.

export calc_round

function calc_round(x::Float64)
    isnan(x) && return NaN
    return round(x)
end

function round_table(xs::Vector{Float64})
    return [calc_round(x) for x in xs]
end

end
