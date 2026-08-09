module AddmodRunner

# Benchmark runner for the addmod cipher.

using ..AddmodCipher
using ..AddmodKeys

export addmod_run_bench

function addmod_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = AddmodCipher.addmod_encrypt(sample)
    for _ in 2:rounds
        out = AddmodCipher.addmod_encrypt(sample)
    end
    return length(out)
end

function addmod_bench_label(rounds::Int = 16)
    return string("addmod x", rounds, " ", AddmodKeys.addmod_key_id())
end

end
