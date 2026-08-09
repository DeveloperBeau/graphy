module ScytaleCipher

# Scytale cipher: block transposition with period 6.

export scytale_encrypt, scytale_decrypt

const SCYTALE_PERM = [1, 4, 2, 5, 3, 6]
const SCYTALE_INV = [1, 3, 5, 2, 4, 6]

function scytale_apply(data::Vector{UInt8}, order::Vector{Int})
    p = length(order)
    out = copy(data)
    for blk in 0:(div(length(data), p) - 1)
        base = blk * p
        for j in 1:p
            out[base + j] = data[base + order[j]]
        end
    end
    return out
end

function scytale_encrypt(data::Vector{UInt8})
    return scytale_apply(data, SCYTALE_PERM)
end

function scytale_decrypt(data::Vector{UInt8})
    return scytale_apply(data, SCYTALE_INV)
end

end
