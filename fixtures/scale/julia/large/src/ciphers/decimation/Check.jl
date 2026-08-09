module DecimationCheck

# Round-trip verification for the decimation cipher.

using ..DecimationCipher

export decimation_verify

function decimation_verify(sample::Vector{UInt8})
    enc = DecimationCipher.decimation_encrypt(sample)
    dec = DecimationCipher.decimation_decrypt(enc)
    return dec == sample
end

end
