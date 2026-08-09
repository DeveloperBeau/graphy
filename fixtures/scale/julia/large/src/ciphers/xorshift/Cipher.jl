module XorShiftCipher

# XorShift cipher: xor against a 16-bit xorshift key stream.

export xorshift_encrypt, xorshift_decrypt

function xorshift_keystream(n::Int)
    state = 911
    ks = Vector{UInt8}(undef, n)
    for i in 1:n
        state = (state ⊻ (state << 3)) & 65535
        state = (state ⊻ (state >> 5)) & 65535
        ks[i] = UInt8(state % 256)
    end
    return ks
end

function xorshift_encrypt(data::Vector{UInt8})
    return data .⊻ xorshift_keystream(length(data))
end

function xorshift_decrypt(data::Vector{UInt8})
    # Xor stream ciphers are symmetric.
    return xorshift_encrypt(data)
end

end
