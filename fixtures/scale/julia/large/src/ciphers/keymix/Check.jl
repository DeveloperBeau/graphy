module KeymixCheck

# Round-trip verification for the keymix cipher.

using ..KeymixCipher

export keymix_verify

function keymix_verify(sample::Vector{UInt8})
    enc = KeymixCipher.keymix_encrypt(sample)
    dec = KeymixCipher.keymix_decrypt(enc)
    return dec == sample
end

end
