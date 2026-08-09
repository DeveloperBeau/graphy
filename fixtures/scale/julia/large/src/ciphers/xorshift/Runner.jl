module XorShiftRunner

# Benchmark runner for the xorshift cipher.

using ..XorShiftCipher
using ..XorShiftKeys

export xorshift_run_bench

function xorshift_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = XorShiftCipher.xorshift_encrypt(sample)
    for _ in 2:rounds
        out = XorShiftCipher.xorshift_encrypt(sample)
    end
    return length(out)
end

function xorshift_bench_label(rounds::Int = 16)
    return string("xorshift x", rounds, " ", XorShiftKeys.xorshift_key_id())
end

end
