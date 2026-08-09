module Eval

using ..Scanner
using ..Tokens
using ..Parser

export eval_expr

function eval_expr(expr::String)
    tokens = Scanner.scan_tokens(expr)
    cursor = Tokens.Cursor(tokens)
    return Parser.parse_expression(cursor)
end

function eval_many(exprs::Vector{String})
    return [eval_expr(e) for e in exprs]
end

end
