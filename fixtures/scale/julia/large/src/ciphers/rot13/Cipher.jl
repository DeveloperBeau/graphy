module Rot13Cipher

# Rot13 cipher: fixed +13 byte rotation.

export rot13_encrypt, rot13_decrypt

function rot13_encrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) + 13, 256)) for b in data]
end

function rot13_decrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) - 13, 256)) for b in data]
end

end
