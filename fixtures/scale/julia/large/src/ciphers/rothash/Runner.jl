module RotHashRunner

# Benchmark runner for the rothash cipher.

using ..RotHashCipher
using ..RotHashKeys

export rothash_run_bench

function rothash_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = RotHashCipher.rothash_digest(sample)
    for _ in 2:rounds
        out = RotHashCipher.rothash_digest(sample)
    end
    return 4
end

function rothash_bench_label(rounds::Int = 16)
    return string("rothash x", rounds, " ", RotHashKeys.rothash_key_id())
end

end
