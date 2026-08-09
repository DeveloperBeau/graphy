module ProdHashCipher

# ProdHash: multiply-accumulate digest (x31).

export prodhash_digest, prodhash_hex

function prodhash_digest(data::Vector{UInt8})
    h = UInt32(7)
    for b in data
        h = h * UInt32(31) + b
    end
    return h
end

function prodhash_hex(data::Vector{UInt8})
    return string(prodhash_digest(data), base = 16, pad = 8)
end

end
