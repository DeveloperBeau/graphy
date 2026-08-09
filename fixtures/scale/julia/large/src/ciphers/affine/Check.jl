module AffineCheck

# Round-trip verification for the affine cipher.

using ..AffineCipher

export affine_verify

function affine_verify(sample::Vector{UInt8})
    enc = AffineCipher.affine_encrypt(sample)
    dec = AffineCipher.affine_decrypt(enc)
    return dec == sample
end

end
