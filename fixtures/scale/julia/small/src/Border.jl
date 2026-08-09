module Border

export border_wrap

function border_rule(width::Int, ch::String = "-")
    return "+" * repeat(ch, width) * "+"
end

function border_wrap(lines::Vector{String}, width::Int)
    boxed = ["|" * rpad(line, width) * "|" for line in lines]
    return vcat([border_rule(width)], boxed, [border_rule(width)])
end

end
