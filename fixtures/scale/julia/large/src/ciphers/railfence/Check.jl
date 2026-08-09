module RailFenceCheck

# Round-trip verification for the railfence cipher.

using ..RailFenceCipher

export railfence_verify

function railfence_verify(sample::Vector{UInt8})
    enc = RailFenceCipher.railfence_encrypt(sample)
    dec = RailFenceCipher.railfence_decrypt(enc)
    return dec == sample
end

end
