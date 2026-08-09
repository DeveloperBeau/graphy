module BlockSwapRunner

# Benchmark runner for the blockswap cipher.

using ..BlockSwapCipher
using ..BlockSwapKeys

export blockswap_run_bench

function blockswap_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = BlockSwapCipher.blockswap_encrypt(sample)
    for _ in 2:rounds
        out = BlockSwapCipher.blockswap_encrypt(sample)
    end
    return length(out)
end

function blockswap_bench_label(rounds::Int = 16)
    return string("blockswap x", rounds, " ", BlockSwapKeys.blockswap_key_id())
end

end
