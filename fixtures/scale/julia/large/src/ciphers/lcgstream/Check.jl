module LcgStreamCheck

# Round-trip verification for the lcgstream cipher.

using ..LcgStreamCipher

export lcgstream_verify

function lcgstream_verify(sample::Vector{UInt8})
    enc = LcgStreamCipher.lcgstream_encrypt(sample)
    dec = LcgStreamCipher.lcgstream_decrypt(enc)
    return dec == sample
end

end
