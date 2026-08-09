module PortaRunner

# Benchmark runner for the porta cipher.

using ..PortaCipher
using ..PortaKeys

export porta_run_bench

function porta_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = PortaCipher.porta_encrypt(sample)
    for _ in 2:rounds
        out = PortaCipher.porta_encrypt(sample)
    end
    return length(out)
end

function porta_bench_label(rounds::Int = 16)
    return string("porta x", rounds, " ", PortaKeys.porta_key_id())
end

end
