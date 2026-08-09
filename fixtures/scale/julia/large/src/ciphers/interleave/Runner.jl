module InterleaveRunner

# Benchmark runner for the interleave cipher.

using ..InterleaveCipher
using ..InterleaveKeys

export interleave_run_bench

function interleave_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = InterleaveCipher.interleave_encrypt(sample)
    for _ in 2:rounds
        out = InterleaveCipher.interleave_encrypt(sample)
    end
    return length(out)
end

function interleave_bench_label(rounds::Int = 16)
    return string("interleave x", rounds, " ", InterleaveKeys.interleave_key_id())
end

end
