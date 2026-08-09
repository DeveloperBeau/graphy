module MaskStreamRunner

# Benchmark runner for the maskstream cipher.

using ..MaskStreamCipher
using ..MaskStreamKeys

export maskstream_run_bench

function maskstream_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = MaskStreamCipher.maskstream_encrypt(sample)
    for _ in 2:rounds
        out = MaskStreamCipher.maskstream_encrypt(sample)
    end
    return length(out)
end

function maskstream_bench_label(rounds::Int = 16)
    return string("maskstream x", rounds, " ", MaskStreamKeys.maskstream_key_id())
end

end
