module SdbmCipher

# Sdbm: multiply-accumulate digest (x65599).

export sdbm_digest, sdbm_hex

function sdbm_digest(data::Vector{UInt8})
    h = UInt32(0)
    for b in data
        h = h * UInt32(65599) + b
    end
    return h
end

function sdbm_hex(data::Vector{UInt8})
    return string(sdbm_digest(data), base = 16, pad = 8)
end

end
