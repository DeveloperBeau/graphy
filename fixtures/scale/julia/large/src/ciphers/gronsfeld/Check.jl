module GronsfeldCheck

# Round-trip verification for the gronsfeld cipher.

using ..GronsfeldCipher

export gronsfeld_verify

function gronsfeld_verify(sample::Vector{UInt8})
    enc = GronsfeldCipher.gronsfeld_encrypt(sample)
    dec = GronsfeldCipher.gronsfeld_decrypt(enc)
    return dec == sample
end

end
