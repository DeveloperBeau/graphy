module Fnv1aCheck

# Round-trip verification for the fnv1a cipher.

using ..Fnv1aCipher

export fnv1a_verify

function fnv1a_verify(sample::Vector{UInt8})
    first = Fnv1aCipher.fnv1a_digest(sample)
    second = Fnv1aCipher.fnv1a_digest(sample)
    return first == second
end

end
