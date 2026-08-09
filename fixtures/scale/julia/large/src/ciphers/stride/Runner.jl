module StrideRunner

# Benchmark runner for the stride cipher.

using ..StrideCipher
using ..StrideKeys

export stride_run_bench

function stride_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = StrideCipher.stride_encrypt(sample)
    for _ in 2:rounds
        out = StrideCipher.stride_encrypt(sample)
    end
    return length(out)
end

function stride_bench_label(rounds::Int = 16)
    return string("stride x", rounds, " ", StrideKeys.stride_key_id())
end

end
