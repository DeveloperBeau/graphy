module Sum32Cipher

# Sum32: multiply-accumulate digest (x1).

export sum32_digest, sum32_hex

function sum32_digest(data::Vector{UInt8})
    h = UInt32(0)
    for b in data
        h = h * UInt32(1) + b
    end
    return h
end

function sum32_hex(data::Vector{UInt8})
    return string(sum32_digest(data), base = 16, pad = 8)
end

end
