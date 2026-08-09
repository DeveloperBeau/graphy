module GronsfeldCipher

# Gronsfeld cipher: repeating key "31415" mixed into the byte stream.

export gronsfeld_encrypt, gronsfeld_decrypt

const GRONSFELD_KEY = "31415"

function gronsfeld_key_bytes()
    return Vector{UInt8}(codeunits(GRONSFELD_KEY))
end

function gronsfeld_encrypt(data::Vector{UInt8})
    key = gronsfeld_key_bytes()
    return UInt8[UInt8(mod(Int(b) + k, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

function gronsfeld_decrypt(data::Vector{UInt8})
    key = gronsfeld_key_bytes()
    return UInt8[UInt8(mod(Int(b) - k, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

end
