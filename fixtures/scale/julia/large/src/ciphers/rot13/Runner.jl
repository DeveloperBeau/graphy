module Rot13Runner

# Benchmark runner for the rot13 cipher.

using ..Rot13Cipher
using ..Rot13Keys

export rot13_run_bench

function rot13_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = Rot13Cipher.rot13_encrypt(sample)
    for _ in 2:rounds
        out = Rot13Cipher.rot13_encrypt(sample)
    end
    return length(out)
end

function rot13_bench_label(rounds::Int = 16)
    return string("rot13 x", rounds, " ", Rot13Keys.rot13_key_id())
end

end
