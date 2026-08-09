module CaesarCheck

# Round-trip verification for the caesar cipher.

using ..CaesarCipher

export caesar_verify

function caesar_verify(sample::Vector{UInt8})
    enc = CaesarCipher.caesar_encrypt(sample)
    dec = CaesarCipher.caesar_decrypt(enc)
    return dec == sample
end

end
