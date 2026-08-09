module XorBasicCheck

# Round-trip verification for the xorbasic cipher.

using ..XorBasicCipher

export xorbasic_verify

function xorbasic_verify(sample::Vector{UInt8})
    enc = XorBasicCipher.xorbasic_encrypt(sample)
    dec = XorBasicCipher.xorbasic_decrypt(enc)
    return dec == sample
end

end
