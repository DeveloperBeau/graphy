module StrideCheck

# Round-trip verification for the stride cipher.

using ..StrideCipher

export stride_verify

function stride_verify(sample::Vector{UInt8})
    enc = StrideCipher.stride_encrypt(sample)
    dec = StrideCipher.stride_decrypt(enc)
    return dec == sample
end

end
