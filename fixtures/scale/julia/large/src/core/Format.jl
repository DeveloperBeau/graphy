module BenchFormat

export fmt_bytes, fmt_micros

function fmt_bytes(n::Int)
    n >= 1048576 && return string(div(n, 1048576), "MiB")
    n >= 1024 && return string(div(n, 1024), "KiB")
    return string(n, "B")
end

function fmt_micros(us::Int)
    us >= 1_000_000 && return string(div(us, 1_000_000), "s")
    return string(us, "us")
end

end
