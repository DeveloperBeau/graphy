module RotHashCipher

# RotHash: rotate-xor digest.

export rothash_digest, rothash_hex

function rothash_digest(data::Vector{UInt8})
    h = UInt32(99991)
    for b in data
        h = ((h << 5) | (h >> 27)) ⊻ UInt32(b)
    end
    return h
end

function rothash_hex(data::Vector{UInt8})
    return string(rothash_digest(data), base = 16, pad = 8)
end

end
