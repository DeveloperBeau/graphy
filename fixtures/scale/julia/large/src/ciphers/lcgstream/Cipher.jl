module LcgStreamCipher

# LcgStream cipher: xor against an LCG key stream (a=1229, c=17).

export lcgstream_encrypt, lcgstream_decrypt

function lcgstream_keystream(n::Int)
    state = 42
    ks = Vector{UInt8}(undef, n)
    for i in 1:n
        state = mod(state * 1229 + 17, 32749)
        ks[i] = UInt8(state % 256)
    end
    return ks
end

function lcgstream_encrypt(data::Vector{UInt8})
    return data .⊻ lcgstream_keystream(length(data))
end

function lcgstream_decrypt(data::Vector{UInt8})
    # Xor stream ciphers are symmetric.
    return lcgstream_encrypt(data)
end

end
