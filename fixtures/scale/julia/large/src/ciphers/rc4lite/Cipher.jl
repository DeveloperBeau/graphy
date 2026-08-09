module Rc4LiteCipher

# Rc4Lite cipher: xor against an LCG key stream (a=181, c=359).

export rc4lite_encrypt, rc4lite_decrypt

function rc4lite_keystream(n::Int)
    state = 17
    ks = Vector{UInt8}(undef, n)
    for i in 1:n
        state = mod(state * 181 + 359, 65521)
        ks[i] = UInt8(state % 256)
    end
    return ks
end

function rc4lite_encrypt(data::Vector{UInt8})
    return data .⊻ rc4lite_keystream(length(data))
end

function rc4lite_decrypt(data::Vector{UInt8})
    # Xor stream ciphers are symmetric.
    return rc4lite_encrypt(data)
end

end
