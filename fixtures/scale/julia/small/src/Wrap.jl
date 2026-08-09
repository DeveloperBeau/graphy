module Wrap

export wrap_text

function wrap_line(line::String, width::Int)
    chunks = String[]
    while length(line) > width
        push!(chunks, line[1:width])
        line = line[(width + 1):end]
    end
    push!(chunks, line)
    return chunks
end

function wrap_text(lines::Vector{String}, width::Int)
    return reduce(vcat, [wrap_line(line, width) for line in lines])
end

end
