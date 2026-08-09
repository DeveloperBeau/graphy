module XorRollRunner

# Benchmark runner for the xorroll cipher.

using ..XorRollCipher
using ..XorRollKeys

export xorroll_run_bench

function xorroll_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = XorRollCipher.xorroll_encrypt(sample)
    for _ in 2:rounds
        out = XorRollCipher.xorroll_encrypt(sample)
    end
    return length(out)
end

function xorroll_bench_label(rounds::Int = 16)
    return string("xorroll x", rounds, " ", XorRollKeys.xorroll_key_id())
end

end
