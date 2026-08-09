module Shift5Check

# Round-trip verification for the shift5 cipher.

using ..Shift5Cipher

export shift5_verify

function shift5_verify(sample::Vector{UInt8})
    enc = Shift5Cipher.shift5_encrypt(sample)
    dec = Shift5Cipher.shift5_decrypt(enc)
    return dec == sample
end

end
