module ProdHashRunner

# Benchmark runner for the prodhash cipher.

using ..ProdHashCipher
using ..ProdHashKeys

export prodhash_run_bench

function prodhash_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = ProdHashCipher.prodhash_digest(sample)
    for _ in 2:rounds
        out = ProdHashCipher.prodhash_digest(sample)
    end
    return 4
end

function prodhash_bench_label(rounds::Int = 16)
    return string("prodhash x", rounds, " ", ProdHashKeys.prodhash_key_id())
end

end
