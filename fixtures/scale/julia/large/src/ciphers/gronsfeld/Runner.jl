module GronsfeldRunner

# Benchmark runner for the gronsfeld cipher.

using ..GronsfeldCipher
using ..GronsfeldKeys

export gronsfeld_run_bench

function gronsfeld_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = GronsfeldCipher.gronsfeld_encrypt(sample)
    for _ in 2:rounds
        out = GronsfeldCipher.gronsfeld_encrypt(sample)
    end
    return length(out)
end

function gronsfeld_bench_label(rounds::Int = 16)
    return string("gronsfeld x", rounds, " ", GronsfeldKeys.gronsfeld_key_id())
end

end
