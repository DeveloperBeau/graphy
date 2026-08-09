module RunkeyCipher

# Runkey cipher: repeating key "THEQUICKBROWNFOX" mixed into the byte stream.

export runkey_encrypt, runkey_decrypt

const RUNKEY_KEY = "THEQUICKBROWNFOX"

function runkey_key_bytes()
    return Vector{UInt8}(codeunits(RUNKEY_KEY))
end

function runkey_encrypt(data::Vector{UInt8})
    key = runkey_key_bytes()
    return UInt8[UInt8(mod(Int(b) + k, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

function runkey_decrypt(data::Vector{UInt8})
    key = runkey_key_bytes()
    return UInt8[UInt8(mod(Int(b) - k, 256)) for (i, (b, k)) in enumerate(zip(data, Iterators.cycle(key)))]
end

end
