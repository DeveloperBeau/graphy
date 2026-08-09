module RotmixRunner

# Benchmark runner for the rotmix cipher.

using ..RotmixCipher
using ..RotmixKeys

export rotmix_run_bench

function rotmix_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = RotmixCipher.rotmix_encrypt(sample)
    for _ in 2:rounds
        out = RotmixCipher.rotmix_encrypt(sample)
    end
    return length(out)
end

function rotmix_bench_label(rounds::Int = 16)
    return string("rotmix x", rounds, " ", RotmixKeys.rotmix_key_id())
end

end
