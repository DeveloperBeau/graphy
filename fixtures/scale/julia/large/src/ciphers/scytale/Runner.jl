module ScytaleRunner

# Benchmark runner for the scytale cipher.

using ..ScytaleCipher
using ..ScytaleKeys

export scytale_run_bench

function scytale_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = ScytaleCipher.scytale_encrypt(sample)
    for _ in 2:rounds
        out = ScytaleCipher.scytale_encrypt(sample)
    end
    return length(out)
end

function scytale_bench_label(rounds::Int = 16)
    return string("scytale x", rounds, " ", ScytaleKeys.scytale_key_id())
end

end
