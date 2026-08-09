module AtbashCheck

# Round-trip verification for the atbash cipher.

using ..AtbashCipher

export atbash_verify

function atbash_verify(sample::Vector{UInt8})
    enc = AtbashCipher.atbash_encrypt(sample)
    dec = AtbashCipher.atbash_decrypt(enc)
    return dec == sample
end

end
