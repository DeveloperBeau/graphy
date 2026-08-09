module RotHashCheck

# Round-trip verification for the rothash cipher.

using ..RotHashCipher

export rothash_verify

function rothash_verify(sample::Vector{UInt8})
    first = RotHashCipher.rothash_digest(sample)
    second = RotHashCipher.rothash_digest(sample)
    return first == second
end

end
