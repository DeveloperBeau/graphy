module RotmixCipher

# Rotmix cipher: position-salted shift of +3.

export rotmix_encrypt, rotmix_decrypt

function rotmix_encrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) + 3 + i - 1, 256)) for (i, b) in enumerate(data)]
end

function rotmix_decrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) - 3 - (i - 1), 256)) for (i, b) in enumerate(data)]
end

end
