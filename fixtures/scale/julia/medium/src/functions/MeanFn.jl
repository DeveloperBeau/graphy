module MeanFn

export calc_mean

function calc_mean(xs::Vector{Float64})
    isempty(xs) && throw(ArgumentError("mean of an empty list"))
    return sum(xs) / length(xs)
end

function running_mean(xs::Vector{Float64})
    return cumsum(xs) ./ collect(1:length(xs))
end

end
