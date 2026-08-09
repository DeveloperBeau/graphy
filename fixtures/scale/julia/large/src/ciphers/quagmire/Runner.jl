module QuagmireRunner

# Benchmark runner for the quagmire cipher.

using ..QuagmireCipher
using ..QuagmireKeys

export quagmire_run_bench

function quagmire_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = QuagmireCipher.quagmire_encrypt(sample)
    for _ in 2:rounds
        out = QuagmireCipher.quagmire_encrypt(sample)
    end
    return length(out)
end

function quagmire_bench_label(rounds::Int = 16)
    return string("quagmire x", rounds, " ", QuagmireKeys.quagmire_key_id())
end

end
