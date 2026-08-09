module Parser

using ..Tokens
using ..Errors
using ..Ops

export parse_expression

function parse_expression(cursor::Tokens.Cursor)
    left = parse_term(cursor)
    while (t = Tokens.peek_token(cursor)) !== nothing && t.value in ("+", "-")
        op = Tokens.next_token(cursor).value
        left = Ops.apply_op(op, left, parse_term(cursor))
    end
    return left
end

function parse_term(cursor::Tokens.Cursor)
    left = parse_factor(cursor)
    while (t = Tokens.peek_token(cursor)) !== nothing && t.value in ("*", "/")
        op = Tokens.next_token(cursor).value
        left = Ops.apply_op(op, left, parse_factor(cursor))
    end
    return left
end

function parse_factor(cursor::Tokens.Cursor)
    token = Tokens.next_token(cursor)
    token === nothing && Errors.raise_calc("unexpected end of expression")
    token.type == :num && return parse(Float64, token.value)
    token.value == "-" && return -parse_factor(cursor)
    token.value == "(" && begin
        inner = parse_expression(cursor)
        Tokens.next_token(cursor)
        return inner
    end
    Errors.raise_calc("unexpected token $(token.value)")
end

end
