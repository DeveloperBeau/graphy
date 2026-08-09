module VigenereCipher

# Vigenere cipher: repeating key "LEMON" mixed into the byte stream.

export vigenere_encrypt, vigenere_decrypt

const VIGENERE_KEY = "LEMON"

function vigenere_key_bytes()
    return Vector{UInt8}(codeunits(VIGENERE_KEY))
end

function vigenere_encrypt(data::Vector{UInt8})
    key = vigenere_key_bytes()
    return UInt8[UInt8(mod(Int(b) + k, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

function vigenere_decrypt(data::Vector{UInt8})
    key = vigenere_key_bytes()
    return UInt8[UInt8(mod(Int(b) - k, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

end
