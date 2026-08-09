module VigenereRunner

# Benchmark runner for the vigenere cipher.

using ..VigenereCipher
using ..VigenereKeys

export vigenere_run_bench

function vigenere_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = VigenereCipher.vigenere_encrypt(sample)
    for _ in 2:rounds
        out = VigenereCipher.vigenere_encrypt(sample)
    end
    return length(out)
end

function vigenere_bench_label(rounds::Int = 16)
    return string("vigenere x", rounds, " ", VigenereKeys.vigenere_key_id())
end

end
