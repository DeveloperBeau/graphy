module CbcXorCheck

# Round-trip verification for the cbcxor cipher.

using ..CbcXorCipher

export cbcxor_verify

function cbcxor_verify(sample::Vector{UInt8})
    enc = CbcXorCipher.cbcxor_encrypt(sample)
    dec = CbcXorCipher.cbcxor_decrypt(enc)
    return dec == sample
end

end
