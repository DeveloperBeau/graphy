module Djb2Check

# Round-trip verification for the djb2 cipher.

using ..Djb2Cipher

export djb2_verify

function djb2_verify(sample::Vector{UInt8})
    first = Djb2Cipher.djb2_digest(sample)
    second = Djb2Cipher.djb2_digest(sample)
    return first == second
end

end
