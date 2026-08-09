module Shift5Cipher

# Shift5 cipher: fixed +5 byte rotation.

export shift5_encrypt, shift5_decrypt

function shift5_encrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) + 5, 256)) for b in data]
end

function shift5_decrypt(data::Vector{UInt8})
    return UInt8[UInt8(mod(Int(b) - 5, 256)) for b in data]
end

end
