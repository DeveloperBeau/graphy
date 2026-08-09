module MaskStreamCheck

# Round-trip verification for the maskstream cipher.

using ..MaskStreamCipher

export maskstream_verify

function maskstream_verify(sample::Vector{UInt8})
    enc = MaskStreamCipher.maskstream_encrypt(sample)
    dec = MaskStreamCipher.maskstream_decrypt(enc)
    return dec == sample
end

end
