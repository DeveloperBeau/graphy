module AdlerCheck

# Round-trip verification for the adler cipher.

using ..AdlerCipher

export adler_verify

function adler_verify(sample::Vector{UInt8})
    first = AdlerCipher.adler_digest(sample)
    second = AdlerCipher.adler_digest(sample)
    return first == second
end

end
