module GcdFn

export calc_gcd

function calc_gcd(a::Int, b::Int)
    a, b = abs(a), abs(b)
    while b != 0
        a, b = b, a % b
    end
    return a
end

end
