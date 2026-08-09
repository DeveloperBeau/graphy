module LcgStreamRunner

# Benchmark runner for the lcgstream cipher.

using ..LcgStreamCipher
using ..LcgStreamKeys

export lcgstream_run_bench

function lcgstream_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = LcgStreamCipher.lcgstream_encrypt(sample)
    for _ in 2:rounds
        out = LcgStreamCipher.lcgstream_encrypt(sample)
    end
    return length(out)
end

function lcgstream_bench_label(rounds::Int = 16)
    return string("lcgstream x", rounds, " ", LcgStreamKeys.lcgstream_key_id())
end

end
