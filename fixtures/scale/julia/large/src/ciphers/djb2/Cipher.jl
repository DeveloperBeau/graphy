module Djb2Cipher

# Djb2: multiply-accumulate digest (x33).

export djb2_digest, djb2_hex

function djb2_digest(data::Vector{UInt8})
    h = UInt32(5381)
    for b in data
        h = h * UInt32(33) + b
    end
    return h
end

function djb2_hex(data::Vector{UInt8})
    return string(djb2_digest(data), base = 16, pad = 8)
end

end
