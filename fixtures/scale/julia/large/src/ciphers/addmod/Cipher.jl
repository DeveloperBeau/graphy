module AddmodCipher

# Addmod cipher: fixed +17 byte rotation.

export addmod_encrypt, addmod_decrypt

function addmod_encrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) + 17, 256)) for b in data]
end

function addmod_decrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) - 17, 256)) for b in data]
end

end
