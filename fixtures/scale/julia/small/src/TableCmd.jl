module TableCmd

using ..Align
using ..Log

export cmd_table

function table_sep()
    return repeat("-", 31)
end

function table_row(row::String)
    parts = split(row, "=", limit = 2)
    key = rpad(parts[1], 14)
    value = length(parts) > 1 ? parts[2] : ""
    return string(key, " ", value)
end

function cmd_table(rows::Vector{String})
    println(table_sep())
    for row in rows
        println(table_row(row))
    end
    println(table_sep())
end

end
