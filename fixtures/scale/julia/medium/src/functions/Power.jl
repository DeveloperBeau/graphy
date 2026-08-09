module Power

export calc_power

function calc_power(base::Float64, exponent::Float64)
    return base^exponent
end

function power_table(bases::Vector{Float64}, exponent::Float64)
    return [calc_power(b, exponent) for b in bases]
end

end
