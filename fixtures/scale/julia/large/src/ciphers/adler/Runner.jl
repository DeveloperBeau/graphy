module AdlerRunner

# Benchmark runner for the adler cipher.

using ..AdlerCipher
using ..AdlerKeys

export adler_run_bench

function adler_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = AdlerCipher.adler_digest(sample)
    for _ in 2:rounds
        out = AdlerCipher.adler_digest(sample)
    end
    return 4
end

function adler_bench_label(rounds::Int = 16)
    return string("adler x", rounds, " ", AdlerKeys.adler_key_id())
end

end
