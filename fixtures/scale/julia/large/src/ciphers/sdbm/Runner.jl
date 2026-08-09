module SdbmRunner

# Benchmark runner for the sdbm cipher.

using ..SdbmCipher
using ..SdbmKeys

export sdbm_run_bench

function sdbm_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = SdbmCipher.sdbm_digest(sample)
    for _ in 2:rounds
        out = SdbmCipher.sdbm_digest(sample)
    end
    return 4
end

function sdbm_bench_label(rounds::Int = 16)
    return string("sdbm x", rounds, " ", SdbmKeys.sdbm_key_id())
end

end
