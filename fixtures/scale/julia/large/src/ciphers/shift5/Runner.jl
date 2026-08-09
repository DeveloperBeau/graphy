module Shift5Runner

# Benchmark runner for the shift5 cipher.

using ..Shift5Cipher
using ..Shift5Keys

export shift5_run_bench

function shift5_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = Shift5Cipher.shift5_encrypt(sample)
    for _ in 2:rounds
        out = Shift5Cipher.shift5_encrypt(sample)
    end
    return length(out)
end

function shift5_bench_label(rounds::Int = 16)
    return string("shift5 x", rounds, " ", Shift5Keys.shift5_key_id())
end

end
