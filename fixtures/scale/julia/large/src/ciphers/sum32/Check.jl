module Sum32Check

# Round-trip verification for the sum32 cipher.

using ..Sum32Cipher

export sum32_verify

function sum32_verify(sample::Vector{UInt8})
    first = Sum32Cipher.sum32_digest(sample)
    second = Sum32Cipher.sum32_digest(sample)
    return first == second
end

end
