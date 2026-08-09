module ZigZagRunner

# Benchmark runner for the zigzag cipher.

using ..ZigZagCipher
using ..ZigZagKeys

export zigzag_run_bench

function zigzag_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = ZigZagCipher.zigzag_encrypt(sample)
    for _ in 2:rounds
        out = ZigZagCipher.zigzag_encrypt(sample)
    end
    return length(out)
end

function zigzag_bench_label(rounds::Int = 16)
    return string("zigzag x", rounds, " ", ZigZagKeys.zigzag_key_id())
end

end
