module AtbashCipher

# Atbash cipher: mirror each byte across the range.

export atbash_encrypt, atbash_decrypt

function atbash_encrypt(data::Vector{UInt8})
    return UInt8[UInt8(255 - Int(b)) for b in data]
end

function atbash_decrypt(data::Vector{UInt8})
    return UInt8[UInt8(255 - Int(b)) for b in data]
end

end
