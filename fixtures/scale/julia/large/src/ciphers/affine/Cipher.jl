module AffineCipher

# Affine cipher: affine map 5x+8 over bytes.

export affine_encrypt, affine_decrypt

function affine_encrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(5 * Int(b) + 8, 256)) for b in data]
end

function affine_decrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(205 * (Int(b) - 8), 256)) for b in data]
end

end
