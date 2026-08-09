module XorShiftCheck

# Round-trip verification for the xorshift cipher.

using ..XorShiftCipher

export xorshift_verify

function xorshift_verify(sample::Vector{UInt8})
    enc = XorShiftCipher.xorshift_encrypt(sample)
    dec = XorShiftCipher.xorshift_decrypt(enc)
    return dec == sample
end

end
