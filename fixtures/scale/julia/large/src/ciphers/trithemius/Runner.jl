module TrithemiusRunner

# Benchmark runner for the trithemius cipher.

using ..TrithemiusCipher
using ..TrithemiusKeys

export trithemius_run_bench

function trithemius_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = TrithemiusCipher.trithemius_encrypt(sample)
    for _ in 2:rounds
        out = TrithemiusCipher.trithemius_encrypt(sample)
    end
    return length(out)
end

function trithemius_bench_label(rounds::Int = 16)
    return string("trithemius x", rounds, " ", TrithemiusKeys.trithemius_key_id())
end

end
