module TrithemiusCipher

# Trithemius cipher: repeating key "ABC" mixed into the byte stream.

export trithemius_encrypt, trithemius_decrypt

const TRITHEMIUS_KEY = "ABC"

function trithemius_key_bytes()
    return Vector{UInt8}(codeunits(TRITHEMIUS_KEY))
end

function trithemius_encrypt(data::Vector{UInt8})
    key = trithemius_key_bytes()
    return UInt8[UInt8(mod(Int(b) + k + i - 1, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

function trithemius_decrypt(data::Vector{UInt8})
    key = trithemius_key_bytes()
    return UInt8[UInt8(mod(Int(b) - k - (i - 1), 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

end
