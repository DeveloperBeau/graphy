module Rot13Check

# Round-trip verification for the rot13 cipher.

using ..Rot13Cipher

export rot13_verify

function rot13_verify(sample::Vector{UInt8})
    enc = Rot13Cipher.rot13_encrypt(sample)
    dec = Rot13Cipher.rot13_decrypt(enc)
    return dec == sample
end

end
