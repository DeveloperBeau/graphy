module Rot47Runner

# Benchmark runner for the rot47 cipher.

using ..Rot47Cipher
using ..Rot47Keys

export rot47_run_bench

function rot47_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = Rot47Cipher.rot47_encrypt(sample)
    for _ in 2:rounds
        out = Rot47Cipher.rot47_encrypt(sample)
    end
    return length(out)
end

function rot47_bench_label(rounds::Int = 16)
    return string("rot47 x", rounds, " ", Rot47Keys.rot47_key_id())
end

end
