module CbcXorRunner

# Benchmark runner for the cbcxor cipher.

using ..CbcXorCipher
using ..CbcXorKeys

export cbcxor_run_bench

function cbcxor_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = CbcXorCipher.cbcxor_encrypt(sample)
    for _ in 2:rounds
        out = CbcXorCipher.cbcxor_encrypt(sample)
    end
    return length(out)
end

function cbcxor_bench_label(rounds::Int = 16)
    return string("cbcxor x", rounds, " ", CbcXorKeys.cbcxor_key_id())
end

end
