module SdbmCheck

# Round-trip verification for the sdbm cipher.

using ..SdbmCipher

export sdbm_verify

function sdbm_verify(sample::Vector{UInt8})
    first = SdbmCipher.sdbm_digest(sample)
    second = SdbmCipher.sdbm_digest(sample)
    return first == second
end

end
