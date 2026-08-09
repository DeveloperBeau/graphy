module ZigZagCheck

# Round-trip verification for the zigzag cipher.

using ..ZigZagCipher

export zigzag_verify

function zigzag_verify(sample::Vector{UInt8})
    enc = ZigZagCipher.zigzag_encrypt(sample)
    dec = ZigZagCipher.zigzag_decrypt(enc)
    return dec == sample
end

end
