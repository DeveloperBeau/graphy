module RotBlocksRunner

# Benchmark runner for the rotblocks cipher.

using ..RotBlocksCipher
using ..RotBlocksKeys

export rotblocks_run_bench

function rotblocks_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = RotBlocksCipher.rotblocks_encrypt(sample)
    for _ in 2:rounds
        out = RotBlocksCipher.rotblocks_encrypt(sample)
    end
    return length(out)
end

function rotblocks_bench_label(rounds::Int = 16)
    return string("rotblocks x", rounds, " ", RotBlocksKeys.rotblocks_key_id())
end

end
