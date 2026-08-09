module AutokeyCheck

# Round-trip verification for the autokey cipher.

using ..AutokeyCipher

export autokey_verify

function autokey_verify(sample::Vector{UInt8})
    enc = AutokeyCipher.autokey_encrypt(sample)
    dec = AutokeyCipher.autokey_decrypt(enc)
    return dec == sample
end

end
