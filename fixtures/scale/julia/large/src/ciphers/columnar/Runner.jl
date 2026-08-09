module ColumnarRunner

# Benchmark runner for the columnar cipher.

using ..ColumnarCipher
using ..ColumnarKeys

export columnar_run_bench

function columnar_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = ColumnarCipher.columnar_encrypt(sample)
    for _ in 2:rounds
        out = ColumnarCipher.columnar_encrypt(sample)
    end
    return length(out)
end

function columnar_bench_label(rounds::Int = 16)
    return string("columnar x", rounds, " ", ColumnarKeys.columnar_key_id())
end

end
