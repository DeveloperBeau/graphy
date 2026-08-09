module CtrXorCheck

# Round-trip verification for the ctrxor cipher.

using ..CtrXorCipher

export ctrxor_verify

function ctrxor_verify(sample::Vector{UInt8})
    enc = CtrXorCipher.ctrxor_encrypt(sample)
    dec = CtrXorCipher.ctrxor_decrypt(enc)
    return dec == sample
end

end
