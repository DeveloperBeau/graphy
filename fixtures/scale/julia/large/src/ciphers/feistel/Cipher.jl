module FeistelCipher

# Feistel cipher: xor against an LCG key stream (a=37, c=11).

export feistel_encrypt, feistel_decrypt

function feistel_keystream(n::Int)
    state = 101
    ks = Vector{UInt8}(undef, n)
    for i in 1:n
        state = mod(state * 37 + 11, 256)
        ks[i] = UInt8(state % 256)
    end
    return ks
end

function feistel_encrypt(data::Vector{UInt8})
    return data .⊻ feistel_keystream(length(data))
end

function feistel_decrypt(data::Vector{UInt8})
    # Xor stream ciphers are symmetric.
    return feistel_encrypt(data)
end

end
