module XorDigestRunner

# Benchmark runner for the xordigest cipher.

using ..XorDigestCipher
using ..XorDigestKeys

export xordigest_run_bench

function xordigest_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = XorDigestCipher.xordigest_digest(sample)
    for _ in 2:rounds
        out = XorDigestCipher.xordigest_digest(sample)
    end
    return 4
end

function xordigest_bench_label(rounds::Int = 16)
    return string("xordigest x", rounds, " ", XorDigestKeys.xordigest_key_id())
end

end
