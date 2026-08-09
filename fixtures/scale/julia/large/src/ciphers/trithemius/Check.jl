module TrithemiusCheck

# Round-trip verification for the trithemius cipher.

using ..TrithemiusCipher

export trithemius_verify

function trithemius_verify(sample::Vector{UInt8})
    enc = TrithemiusCipher.trithemius_encrypt(sample)
    dec = TrithemiusCipher.trithemius_decrypt(enc)
    return dec == sample
end

end
