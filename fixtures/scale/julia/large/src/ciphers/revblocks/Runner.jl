module RevBlocksRunner

# Benchmark runner for the revblocks cipher.

using ..RevBlocksCipher
using ..RevBlocksKeys

export revblocks_run_bench

function revblocks_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = RevBlocksCipher.revblocks_encrypt(sample)
    for _ in 2:rounds
        out = RevBlocksCipher.revblocks_encrypt(sample)
    end
    return length(out)
end

function revblocks_bench_label(rounds::Int = 16)
    return string("revblocks x", rounds, " ", RevBlocksKeys.revblocks_key_id())
end

end
