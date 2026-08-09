module BenchCsv

export csv_row, csv_header

function csv_escape(field::String)
    return string('"', replace(field, "\"" => "\"\""), '"')
end

function csv_row(fields::Vector{String})
    return join([csv_escape(f) for f in fields], ",")
end

function csv_header()
    return csv_row(["cipher", "rounds", "bytes", "micros"])
end

end
