module Sum32Runner

# Benchmark runner for the sum32 cipher.

using ..Sum32Cipher
using ..Sum32Keys

export sum32_run_bench

function sum32_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = Sum32Cipher.sum32_digest(sample)
    for _ in 2:rounds
        out = Sum32Cipher.sum32_digest(sample)
    end
    return 4
end

function sum32_bench_label(rounds::Int = 16)
    return string("sum32 x", rounds, " ", Sum32Keys.sum32_key_id())
end

end
