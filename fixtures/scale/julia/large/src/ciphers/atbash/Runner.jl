module AtbashRunner

# Benchmark runner for the atbash cipher.

using ..AtbashCipher
using ..AtbashKeys

export atbash_run_bench

function atbash_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = AtbashCipher.atbash_encrypt(sample)
    for _ in 2:rounds
        out = AtbashCipher.atbash_encrypt(sample)
    end
    return length(out)
end

function atbash_bench_label(rounds::Int = 16)
    return string("atbash x", rounds, " ", AtbashKeys.atbash_key_id())
end

end
