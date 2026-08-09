module FeistelRunner

# Benchmark runner for the feistel cipher.

using ..FeistelCipher
using ..FeistelKeys

export feistel_run_bench

function feistel_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = FeistelCipher.feistel_encrypt(sample)
    for _ in 2:rounds
        out = FeistelCipher.feistel_encrypt(sample)
    end
    return length(out)
end

function feistel_bench_label(rounds::Int = 16)
    return string("feistel x", rounds, " ", FeistelKeys.feistel_key_id())
end

end
