module History

export history_add, history_entries, history_clear

const ENTRIES = String[]

function history_add(expr::String, result::Float64)
    push!(ENTRIES, string(expr, " = ", result))
end

function history_entries()
    return copy(ENTRIES)
end

function history_clear()
    empty!(ENTRIES)
end

end
