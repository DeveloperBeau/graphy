module RunkeyCheck

# Round-trip verification for the runkey cipher.

using ..RunkeyCipher

export runkey_verify

function runkey_verify(sample::Vector{UInt8})
    enc = RunkeyCipher.runkey_encrypt(sample)
    dec = RunkeyCipher.runkey_decrypt(enc)
    return dec == sample
end

end
