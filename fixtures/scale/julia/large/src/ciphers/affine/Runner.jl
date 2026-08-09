module AffineRunner

# Benchmark runner for the affine cipher.

using ..AffineCipher
using ..AffineKeys

export affine_run_bench

function affine_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = AffineCipher.affine_encrypt(sample)
    for _ in 2:rounds
        out = AffineCipher.affine_encrypt(sample)
    end
    return length(out)
end

function affine_bench_label(rounds::Int = 16)
    return string("affine x", rounds, " ", AffineKeys.affine_key_id())
end

end
