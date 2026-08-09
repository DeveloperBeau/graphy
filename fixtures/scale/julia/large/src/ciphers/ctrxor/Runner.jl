module CtrXorRunner

# Benchmark runner for the ctrxor cipher.

using ..CtrXorCipher
using ..CtrXorKeys

export ctrxor_run_bench

function ctrxor_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = CtrXorCipher.ctrxor_encrypt(sample)
    for _ in 2:rounds
        out = CtrXorCipher.ctrxor_encrypt(sample)
    end
    return length(out)
end

function ctrxor_bench_label(rounds::Int = 16)
    return string("ctrxor x", rounds, " ", CtrXorKeys.ctrxor_key_id())
end

end
