module Ops

using ..Errors

export apply_op

function apply_op(op::String, a::Float64, b::Float64)
    op == "+" && return a + b
    op == "-" && return a - b
    op == "*" && return a * b
    op == "/" && return b == 0 ? Errors.raise_calc("divide by zero") : a / b
    Errors.raise_calc("unknown operator $op")
end

end
