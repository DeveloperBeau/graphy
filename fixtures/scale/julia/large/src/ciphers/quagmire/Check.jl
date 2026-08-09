module QuagmireCheck

# Round-trip verification for the quagmire cipher.

using ..QuagmireCipher

export quagmire_verify

function quagmire_verify(sample::Vector{UInt8})
    enc = QuagmireCipher.quagmire_encrypt(sample)
    dec = QuagmireCipher.quagmire_decrypt(enc)
    return dec == sample
end

end
