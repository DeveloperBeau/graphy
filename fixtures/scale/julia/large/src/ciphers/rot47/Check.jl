module Rot47Check

# Round-trip verification for the rot47 cipher.

using ..Rot47Cipher

export rot47_verify

function rot47_verify(sample::Vector{UInt8})
    enc = Rot47Cipher.rot47_encrypt(sample)
    dec = Rot47Cipher.rot47_decrypt(enc)
    return dec == sample
end

end
