module CaesarRunner

# Benchmark runner for the caesar cipher.

using ..CaesarCipher
using ..CaesarKeys

export caesar_run_bench

function caesar_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = CaesarCipher.caesar_encrypt(sample)
    for _ in 2:rounds
        out = CaesarCipher.caesar_encrypt(sample)
    end
    return length(out)
end

function caesar_bench_label(rounds::Int = 16)
    return string("caesar x", rounds, " ", CaesarKeys.caesar_key_id())
end

end
