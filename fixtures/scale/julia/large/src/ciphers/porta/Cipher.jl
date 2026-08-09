module PortaCipher

# Porta cipher: repeating key "GLACIER" mixed into the byte stream.

export porta_encrypt, porta_decrypt

const PORTA_KEY = "GLACIER"

function porta_key_bytes()
    return Vector{UInt8}(codeunits(PORTA_KEY))
end

function porta_encrypt(data::Vector{UInt8})
    key = porta_key_bytes()
    return UInt8[UInt8(mod(k - Int(b), 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

function porta_decrypt(data::Vector{UInt8})
    # Subtraction against the key stream is its own inverse.
    return porta_encrypt(data)
end

end
