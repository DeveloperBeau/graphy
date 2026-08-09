module DecimationCipher

# Decimation cipher: affine map 7x+0 over bytes.

export decimation_encrypt, decimation_decrypt

function decimation_encrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(7 * Int(b) + 0, 256)) for b in data]
end

function decimation_decrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(183 * (Int(b) - 0), 256)) for b in data]
end

end
