module XorBasicCipher

# XorBasic cipher: xor against a fixed 1-byte mask.

export xorbasic_encrypt, xorbasic_decrypt

const XORBASIC_MASK = UInt8[0x5a]

function xorbasic_keystream(n::Int)
    mask = XORBASIC_MASK
    return UInt8[mask[mod(i - 1, length(mask)) + 1] for i in 1:n]
end

function xorbasic_encrypt(data::Vector{UInt8})
    return data .⊻ xorbasic_keystream(length(data))
end

function xorbasic_decrypt(data::Vector{UInt8})
    # Xor stream ciphers are symmetric.
    return xorbasic_encrypt(data)
end

end
