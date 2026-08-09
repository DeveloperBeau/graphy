module KeymixCipher

# Keymix cipher: repeating key "ZEBRA" mixed into the byte stream.

export keymix_encrypt, keymix_decrypt

const KEYMIX_KEY = "ZEBRA"

function keymix_key_bytes()
    return Vector{UInt8}(codeunits(KEYMIX_KEY))
end

function keymix_encrypt(data::Vector{UInt8})
    key = keymix_key_bytes()
    return UInt8[UInt8(mod(Int(b) + k + 7, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

function keymix_decrypt(data::Vector{UInt8})
    key = keymix_key_bytes()
    return UInt8[UInt8(mod(Int(b) - k - 7, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

end
