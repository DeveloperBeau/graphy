module CtrXorCipher

# CtrXor cipher: xor against an LCG key stream (a=1, c=1).

export ctrxor_encrypt, ctrxor_decrypt

function ctrxor_keystream(n::Int)
    state = 7
    ks = Vector{UInt8}(undef, n)
    for i in 1:n
        state = mod(state * 1 + 1, 256)
        ks[i] = UInt8(state % 256)
    end
    return ks
end

function ctrxor_encrypt(data::Vector{UInt8})
    return data .⊻ ctrxor_keystream(length(data))
end

function ctrxor_decrypt(data::Vector{UInt8})
    # Xor stream ciphers are symmetric.
    return ctrxor_encrypt(data)
end

end
