module AddmodCheck

# Round-trip verification for the addmod cipher.

using ..AddmodCipher

export addmod_verify

function addmod_verify(sample::Vector{UInt8})
    enc = AddmodCipher.addmod_encrypt(sample)
    dec = AddmodCipher.addmod_decrypt(enc)
    return dec == sample
end

end
