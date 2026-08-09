module RunkeyRunner

# Benchmark runner for the runkey cipher.

using ..RunkeyCipher
using ..RunkeyKeys

export runkey_run_bench

function runkey_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = RunkeyCipher.runkey_encrypt(sample)
    for _ in 2:rounds
        out = RunkeyCipher.runkey_encrypt(sample)
    end
    return length(out)
end

function runkey_bench_label(rounds::Int = 16)
    return string("runkey x", rounds, " ", RunkeyKeys.runkey_key_id())
end

end
