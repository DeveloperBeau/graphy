module FeistelCheck

# Round-trip verification for the feistel cipher.

using ..FeistelCipher

export feistel_verify

function feistel_verify(sample::Vector{UInt8})
    enc = FeistelCipher.feistel_encrypt(sample)
    dec = FeistelCipher.feistel_decrypt(enc)
    return dec == sample
end

end
