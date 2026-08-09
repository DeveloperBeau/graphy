module XorBasicRunner

# Benchmark runner for the xorbasic cipher.

using ..XorBasicCipher
using ..XorBasicKeys

export xorbasic_run_bench

function xorbasic_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = XorBasicCipher.xorbasic_encrypt(sample)
    for _ in 2:rounds
        out = XorBasicCipher.xorbasic_encrypt(sample)
    end
    return length(out)
end

function xorbasic_bench_label(rounds::Int = 16)
    return string("xorbasic x", rounds, " ", XorBasicKeys.xorbasic_key_id())
end

end
