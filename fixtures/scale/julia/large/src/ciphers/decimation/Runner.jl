module DecimationRunner

# Benchmark runner for the decimation cipher.

using ..DecimationCipher
using ..DecimationKeys

export decimation_run_bench

function decimation_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = DecimationCipher.decimation_encrypt(sample)
    for _ in 2:rounds
        out = DecimationCipher.decimation_encrypt(sample)
    end
    return length(out)
end

function decimation_bench_label(rounds::Int = 16)
    return string("decimation x", rounds, " ", DecimationKeys.decimation_key_id())
end

end
