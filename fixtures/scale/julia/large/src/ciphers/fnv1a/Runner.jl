module Fnv1aRunner

# Benchmark runner for the fnv1a cipher.

using ..Fnv1aCipher
using ..Fnv1aKeys

export fnv1a_run_bench

function fnv1a_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = Fnv1aCipher.fnv1a_digest(sample)
    for _ in 2:rounds
        out = Fnv1aCipher.fnv1a_digest(sample)
    end
    return 4
end

function fnv1a_bench_label(rounds::Int = 16)
    return string("fnv1a x", rounds, " ", Fnv1aKeys.fnv1a_key_id())
end

end
