module BeaufortCheck

# Round-trip verification for the beaufort cipher.

using ..BeaufortCipher

export beaufort_verify

function beaufort_verify(sample::Vector{UInt8})
    enc = BeaufortCipher.beaufort_encrypt(sample)
    dec = BeaufortCipher.beaufort_decrypt(enc)
    return dec == sample
end

end
