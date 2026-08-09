module Scanner

using ..Tokens

export scan_tokens

function scan_number(expr::String, start::Int)
    stop = start
    while stop <= lastindex(expr) && (isdigit(expr[stop]) || expr[stop] == '.')
        stop += 1
    end
    return expr[start:(stop - 1)], stop
end

function scan_tokens(expr::String)
    tokens = Tokens.Token[]
    i = firstindex(expr)
    while i <= lastindex(expr)
        c = expr[i]
        if c == ' '
            i += 1
        elseif isdigit(c)
            text, i = scan_number(expr, i)
            push!(tokens, Tokens.Token(:num, text))
        else
            push!(tokens, Tokens.Token(:op, string(c)))
            i += 1
        end
    end
    return tokens
end

end
