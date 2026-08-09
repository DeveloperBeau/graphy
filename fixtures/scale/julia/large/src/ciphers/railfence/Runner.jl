module RailFenceRunner

# Benchmark runner for the railfence cipher.

using ..RailFenceCipher
using ..RailFenceKeys

export railfence_run_bench

function railfence_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = RailFenceCipher.railfence_encrypt(sample)
    for _ in 2:rounds
        out = RailFenceCipher.railfence_encrypt(sample)
    end
    return length(out)
end

function railfence_bench_label(rounds::Int = 16)
    return string("railfence x", rounds, " ", RailFenceKeys.railfence_key_id())
end

end
