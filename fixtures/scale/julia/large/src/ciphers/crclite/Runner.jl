module CrcLiteRunner

# Benchmark runner for the crclite cipher.

using ..CrcLiteCipher
using ..CrcLiteKeys

export crclite_run_bench

function crclite_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = CrcLiteCipher.crclite_digest(sample)
    for _ in 2:rounds
        out = CrcLiteCipher.crclite_digest(sample)
    end
    return 4
end

function crclite_bench_label(rounds::Int = 16)
    return string("crclite x", rounds, " ", CrcLiteKeys.crclite_key_id())
end

end
