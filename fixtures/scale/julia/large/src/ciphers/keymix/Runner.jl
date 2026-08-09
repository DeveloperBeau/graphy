module KeymixRunner

# Benchmark runner for the keymix cipher.

using ..KeymixCipher
using ..KeymixKeys

export keymix_run_bench

function keymix_run_bench(sample::Vector{UInt8}, rounds::Int = 16)
    out = KeymixCipher.keymix_encrypt(sample)
    for _ in 2:rounds
        out = KeymixCipher.keymix_encrypt(sample)
    end
    return length(out)
end

function keymix_bench_label(rounds::Int = 16)
    return string("keymix x", rounds, " ", KeymixKeys.keymix_key_id())
end

end
