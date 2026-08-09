module BeaufortRunner

# Benchmark runner for the beaufort cipher.

using ..BeaufortCipher
using ..BeaufortKeys

export beaufort_run_bench

function beaufort_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = BeaufortCipher.beaufort_encrypt(sample)
    for _ in 2:rounds
        out = BeaufortCipher.beaufort_encrypt(sample)
    end
    return length(out)
end

function beaufort_bench_label(rounds::Int = 16)
    return string("beaufort x", rounds, " ", BeaufortKeys.beaufort_key_id())
end

end
