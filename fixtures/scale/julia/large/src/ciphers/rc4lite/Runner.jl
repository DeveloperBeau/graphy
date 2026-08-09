module Rc4LiteRunner

# Benchmark runner for the rc4lite cipher.

using ..Rc4LiteCipher
using ..Rc4LiteKeys

export rc4lite_run_bench

function rc4lite_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = Rc4LiteCipher.rc4lite_encrypt(sample)
    for _ in 2:rounds
        out = Rc4LiteCipher.rc4lite_encrypt(sample)
    end
    return length(out)
end

function rc4lite_bench_label(rounds::Int = 16)
    return string("rc4lite x", rounds, " ", Rc4LiteKeys.rc4lite_key_id())
end

end
