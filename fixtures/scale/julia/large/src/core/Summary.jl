module BenchSummary

using ..BenchRegistry

export summary_print

function summary_row(name::String, bytes::String, time::String)
    return string(rpad(name, 14), " ", lpad(bytes, 10), " ", lpad(time, 10))
end

function summary_print()
    println("ciphers run: ", BenchRegistry.registered_count())
    println(summary_row("cipher", "bytes", "time"))
    println(summary_row("------", "-----", "----"))
end

end
