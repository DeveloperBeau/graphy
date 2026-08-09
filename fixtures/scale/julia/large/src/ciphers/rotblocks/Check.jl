module RotBlocksCheck

# Round-trip verification for the rotblocks cipher.

using ..RotBlocksCipher

export rotblocks_verify

function rotblocks_verify(sample::Vector{UInt8})
    enc = RotBlocksCipher.rotblocks_encrypt(sample)
    dec = RotBlocksCipher.rotblocks_decrypt(enc)
    return dec == sample
end

end
