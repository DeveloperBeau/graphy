module ColumnarCheck

# Round-trip verification for the columnar cipher.

using ..ColumnarCipher

export columnar_verify

function columnar_verify(sample::Vector{UInt8})
    enc = ColumnarCipher.columnar_encrypt(sample)
    dec = ColumnarCipher.columnar_decrypt(enc)
    return dec == sample
end

end
