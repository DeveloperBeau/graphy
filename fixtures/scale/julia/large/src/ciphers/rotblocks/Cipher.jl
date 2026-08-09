module RotBlocksCipher

# RotBlocks cipher: block transposition with period 6.

export rotblocks_encrypt, rotblocks_decrypt

const ROTBLOCKS_PERM = [3, 4, 5, 6, 1, 2]
const ROTBLOCKS_INV = [5, 6, 1, 2, 3, 4]

function rotblocks_apply(data::Vector{UInt8}, order::Vector{Int})
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

function rotblocks_encrypt(data::Vector{UInt8})
    return rotblocks_apply(data, ROTBLOCKS_PERM)
end

function rotblocks_decrypt(data::Vector{UInt8})
    return rotblocks_apply(data, ROTBLOCKS_INV)
end

end
