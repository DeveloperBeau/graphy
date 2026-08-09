module FactorialFn

export calc_factorial

function calc_factorial(n::Int)
    n < 0 && throw(DomainError(n, "factorial of a negative number"))
    acc = big(1)
    for i in 2:n
        acc *= i
    end
    return acc
end

end
