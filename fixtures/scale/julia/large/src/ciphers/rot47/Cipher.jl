module Rot47Cipher

# Rot47 cipher: fixed +47 byte rotation.

export rot47_encrypt, rot47_decrypt

function rot47_encrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) + 47, 256)) for b in data]
end

function rot47_decrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) - 47, 256)) for b in data]
end

end
