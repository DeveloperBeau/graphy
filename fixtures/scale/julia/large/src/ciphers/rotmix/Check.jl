module RotmixCheck

# Round-trip verification for the rotmix cipher.

using ..RotmixCipher

export rotmix_verify

function rotmix_verify(sample::Vector{UInt8})
    enc = RotmixCipher.rotmix_encrypt(sample)
    dec = RotmixCipher.rotmix_decrypt(enc)
    return dec == sample
end

end
