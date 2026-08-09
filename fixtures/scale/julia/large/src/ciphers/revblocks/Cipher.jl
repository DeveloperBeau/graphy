module RevBlocksCipher

# RevBlocks cipher: block transposition with period 4.

export revblocks_encrypt, revblocks_decrypt

const REVBLOCKS_PERM = [4, 3, 2, 1]
const REVBLOCKS_INV = [4, 3, 2, 1]

function revblocks_apply(data::Vector{UInt8}, order::Vector{Int})
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

function revblocks_encrypt(data::Vector{UInt8})
    return revblocks_apply(data, REVBLOCKS_PERM)
end

function revblocks_decrypt(data::Vector{UInt8})
    return revblocks_apply(data, REVBLOCKS_INV)
end

end
