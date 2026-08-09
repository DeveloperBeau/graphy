module QuagmireCipher

# Quagmire cipher: repeating key "OCEAN" mixed into the byte stream.

export quagmire_encrypt, quagmire_decrypt

const QUAGMIRE_KEY = "OCEAN"

function quagmire_key_bytes()
    return Vector{UInt8}(codeunits(QUAGMIRE_KEY))
end

function quagmire_encrypt(data::Vector{UInt8})
    key = quagmire_key_bytes()
    return UInt8[UInt8(mod(Int(b) + k + 11, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

function quagmire_decrypt(data::Vector{UInt8})
    key = quagmire_key_bytes()
    return UInt8[UInt8(mod(Int(b) - k - 11, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

end
