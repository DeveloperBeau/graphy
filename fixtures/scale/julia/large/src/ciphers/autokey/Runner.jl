module AutokeyRunner

# Benchmark runner for the autokey cipher.

using ..AutokeyCipher
using ..AutokeyKeys

export autokey_run_bench

function autokey_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = AutokeyCipher.autokey_encrypt(sample)
    for _ in 2:rounds
        out = AutokeyCipher.autokey_encrypt(sample)
    end
    return length(out)
end

function autokey_bench_label(rounds::Int = 16)
    return string("autokey x", rounds, " ", AutokeyKeys.autokey_key_id())
end

end
