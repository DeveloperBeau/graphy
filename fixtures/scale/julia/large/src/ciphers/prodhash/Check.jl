module ProdHashCheck

# Round-trip verification for the prodhash cipher.

using ..ProdHashCipher

export prodhash_verify

function prodhash_verify(sample::Vector{UInt8})
    first = ProdHashCipher.prodhash_digest(sample)
    second = ProdHashCipher.prodhash_digest(sample)
    return first == second
end

end
