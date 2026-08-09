module Colors

export colorize

const CODES = Dict("red" => 31, "green" => 32, "yellow" => 33, "blue" => 34, "cyan" => 36)

function color_code(name::String)
    return get(CODES, name, 0)
end

function colorize(name::String, text::String)
    code = color_code(name)
    return "\e[$(code)m$(text)\e[0m"
end

end
