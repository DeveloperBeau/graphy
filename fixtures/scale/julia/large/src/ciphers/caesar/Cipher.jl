module CaesarCipher

# Caesar cipher: fixed +3 byte rotation.

export caesar_encrypt, caesar_decrypt

function caesar_encrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) + 3, 256)) for b in data]
end

function caesar_decrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) - 3, 256)) for b in data]
end

end
