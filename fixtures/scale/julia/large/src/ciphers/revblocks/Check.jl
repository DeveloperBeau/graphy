module RevBlocksCheck

# Round-trip verification for the revblocks cipher.

using ..RevBlocksCipher

export revblocks_verify

function revblocks_verify(sample::Vector{UInt8})
    enc = RevBlocksCipher.revblocks_encrypt(sample)
    dec = RevBlocksCipher.revblocks_decrypt(enc)
    return dec == sample
end

end
