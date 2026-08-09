module XorRollCheck

# Round-trip verification for the xorroll cipher.

using ..XorRollCipher

export xorroll_verify

function xorroll_verify(sample::Vector{UInt8})
    enc = XorRollCipher.xorroll_encrypt(sample)
    dec = XorRollCipher.xorroll_decrypt(enc)
    return dec == sample
end

end
