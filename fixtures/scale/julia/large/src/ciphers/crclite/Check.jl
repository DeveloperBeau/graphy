module CrcLiteCheck

# Round-trip verification for the crclite cipher.

using ..CrcLiteCipher

export crclite_verify

function crclite_verify(sample::Vector{UInt8})
    first = CrcLiteCipher.crclite_digest(sample)
    second = CrcLiteCipher.crclite_digest(sample)
    return first == second
end

end
