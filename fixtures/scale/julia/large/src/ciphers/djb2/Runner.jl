module Djb2Runner

# Benchmark runner for the djb2 cipher.

using ..Djb2Cipher
using ..Djb2Keys

export djb2_run_bench

function djb2_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = Djb2Cipher.djb2_digest(sample)
    for _ in 2:rounds
        out = Djb2Cipher.djb2_digest(sample)
    end
    return 4
end

function djb2_bench_label(rounds::Int = 16)
    return string("djb2 x", rounds, " ", Djb2Keys.djb2_key_id())
end

end
