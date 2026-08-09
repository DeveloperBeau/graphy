module InterleaveCheck

# Round-trip verification for the interleave cipher.

using ..InterleaveCipher

export interleave_verify

function interleave_verify(sample::Vector{UInt8})
    enc = InterleaveCipher.interleave_encrypt(sample)
    dec = InterleaveCipher.interleave_decrypt(enc)
    return dec == sample
end

end
