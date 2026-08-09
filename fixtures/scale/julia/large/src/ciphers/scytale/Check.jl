module ScytaleCheck

# Round-trip verification for the scytale cipher.

using ..ScytaleCipher

export scytale_verify

function scytale_verify(sample::Vector{UInt8})
    enc = ScytaleCipher.scytale_encrypt(sample)
    dec = ScytaleCipher.scytale_decrypt(enc)
    return dec == sample
end

end
