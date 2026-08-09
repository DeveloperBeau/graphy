module SignumFn

# Signum.

export calc_signum

function calc_signum(x::Float64)
    isnan(x) && return NaN
    return sign(x)
end

function signum_table(xs::Vector{Float64})
    return [calc_signum(x) for x in xs]
end

end
