module BeaufortCipher

# Beaufort cipher: repeating key "FORTRESS" mixed into the byte stream.

export beaufort_encrypt, beaufort_decrypt

const BEAUFORT_KEY = "FORTRESS"

function beaufort_key_bytes()
    return Vector{UInt8}(codeunits(BEAUFORT_KEY))
end

function beaufort_encrypt(data::Vector{UInt8})
    key = beaufort_key_bytes()
    return UInt8[UInt8(mod(k - Int(b), 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

function beaufort_decrypt(data::Vector{UInt8})
    # Subtraction against the key stream is its own inverse.
    return beaufort_encrypt(data)
end

end
