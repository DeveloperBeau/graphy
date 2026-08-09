module Fnv1aCipher

# Fnv1a: xor-then-multiply digest.

export fnv1a_digest, fnv1a_hex

function fnv1a_digest(data::Vector{UInt8})
    h = UInt32(2166136261)
    for b in data
        h = (h ⊻ b) * UInt32(16777619)
    end
    return h
end

function fnv1a_hex(data::Vector{UInt8})
    return string(fnv1a_digest(data), base = 16, pad = 8)
end

end
