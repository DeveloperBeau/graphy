module AutokeyCipher

# Autokey cipher: repeating key "QUEEN" mixed into the byte stream.

export autokey_encrypt, autokey_decrypt

const AUTOKEY_KEY = "QUEEN"

function autokey_key_bytes()
    return Vector{UInt8}(codeunits(AUTOKEY_KEY))
end

function autokey_encrypt(data::Vector{UInt8})
    key = autokey_key_bytes()
    return UInt8[UInt8(mod(Int(b) + k, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

function autokey_decrypt(data::Vector{UInt8})
    key = autokey_key_bytes()
    return UInt8[UInt8(mod(Int(b) - k, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

end
