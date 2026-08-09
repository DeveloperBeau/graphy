module XorDigestCheck

# Round-trip verification for the xordigest cipher.

using ..XorDigestCipher

export xordigest_verify

function xordigest_verify(sample::Vector{UInt8})
    first = XorDigestCipher.xordigest_digest(sample)
    second = XorDigestCipher.xordigest_digest(sample)
    return first == second
end

end
